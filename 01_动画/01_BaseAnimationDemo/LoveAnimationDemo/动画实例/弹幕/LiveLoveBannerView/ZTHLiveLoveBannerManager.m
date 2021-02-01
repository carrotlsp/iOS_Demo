//
//  ZTHLiveLoveBannerManager.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import "ZTHLiveLoveBannerManager.h"


// 横幅视图最高位置
#define AllBannerViewCount 3

@interface ZTHLiveLoveBannerManager ()
/// 横幅视图数组
@property (nonatomic, strong) NSMutableArray<ZTHLiveLoveBannerView*> *waitingbannerViewArray;
/// 展示中横幅视图数组
@property (nonatomic, strong) NSMutableArray<ZTHLiveLoveBannerView*> *showingBannerViewArray;
/// 横幅数据数组
@property (nonatomic, strong) NSMutableArray<ZTHLiveLoveBannerItem*> *waitingBannerItemArray;
/// 横幅容器
@property (nonatomic, strong) UIView *bannerContainerView;

@end

@implementation ZTHLiveLoveBannerManager

#pragma mark - Public Method
- (void)pushBannerItem:(ZTHLiveLoveBannerItem*)item {
    // 1.判断能否展示
    if (self.isCanShowBannerBarrage == NO) {
        return;
    }
    
    // 2.showingBannerViewArray数组中是否有相同的用户赠送的爱心（有就终止）
    for (ZTHLiveLoveBannerView *showingBannerView in self.showingBannerViewArray) {
        if ([showingBannerView.item.userId isEqualToString:item.userId] ) {
            [showingBannerView showingAddNumberAnimation];
            return;
        }
    }
    
    // 3.waitingBannerItemArray数组中是否有相关的用户赠送的爱心
    for (ZTHLiveLoveBannerItem *wattingItem in self.waitingBannerItemArray) {
        if ([wattingItem.userId isEqualToString:item.userId] ) {
            wattingItem.loveCount ++;
            return;
        }
    }
    
    // 4.最终都没找到就加入待展示数组中
    [self.waitingBannerItemArray addObject:item];
    [self showNextBannerIfNeed];
}

#pragma mark - Private Method
/// 如果有，展示下一个横幅
- (void)showNextBannerIfNeed {
    
    // 1.判断（是否有空闲视图&&是否有待展示数据）
    if (self.waitingbannerViewArray.count == 0 || self.waitingBannerItemArray.count == 0) {
        return;
    }
    // 2.取横幅视图
    ZTHLiveLoveBannerView *bannerView = [self dequeueUsableBannerView];
    
    // 3.取横幅数据
    ZTHLiveLoveBannerItem *item = [self.waitingBannerItemArray firstObject];
    [self.waitingBannerItemArray removeObject:item];
    bannerView.item = item;
    
    // 4.计算横幅摆放位置
    item.showingRow = AllBannerViewCount - 1;
    CGFloat bannerX = 0 - item.viewWidth;
    CGFloat bannerY = (LiveLoveBannerViewHeight + LiveLoveBannerViewMargin) * item.showingRow;
    bannerView.frame = CGRectMake(bannerX, bannerY, item.viewWidth, LiveLoveBannerViewHeight);
    
    // 5.播放展示动画
    [bannerView showingView];
    [self.showingBannerViewArray addObject:bannerView];
    [self relayoutBannerViewArray];
    
    // 6.bannerView的状态变更监听
    __weak typeof(self) weakSelf = self;
    bannerView.item.bannerViewStateChangeBlock = ^(ZTHLiveLoveBannerView *bannerView) {
        [weakSelf dealwithBannerViewStateChange:bannerView];
    };
}

/// 处理bannerView的状态变更
- (void)dealwithBannerViewStateChange:(ZTHLiveLoveBannerView*)bannerView {
    if (bannerView.item.bannerViewState == LiveLoveBannerViewStateHiding) {
        [self.showingBannerViewArray removeObject:bannerView];
    } else if (bannerView.item.bannerViewState == LiveLoveBannerViewStateHidden) {
        [self.waitingbannerViewArray addObject:bannerView];
        [self showNextBannerIfNeed];
    }
}
/// 取出可用的横幅视图
- (ZTHLiveLoveBannerView*)dequeueUsableBannerView {
    ZTHLiveLoveBannerView *bannerView = [self.waitingbannerViewArray firstObject];
    [self.waitingbannerViewArray removeObject:bannerView];
    return bannerView;
}

/// 重新布局正在展示的视图
- (void)relayoutBannerViewArray {
    // 1.更新每个bannerView所属的行
    int showingCount = (int)self.showingBannerViewArray.count;
    NSLog(@"%i", showingCount);
    for (int i = 0; i < showingCount; i++) {
        ZTHLiveLoveBannerView *bannerView = [self.showingBannerViewArray objectAtIndex:i];
        bannerView.item.showingRow = i + AllBannerViewCount - showingCount;
    }
    NSLog(@"%i", showingCount);
    [UIView animateWithDuration:0.3 animations:^{
        for (int i = 0; i < self.showingBannerViewArray.count; i++) {
            ZTHLiveLoveBannerView *bannerView = [self.showingBannerViewArray objectAtIndex:i];
            if (bannerView.item.bannerViewState != LiveLoveBannerViewStateWaitting ) {
                bannerView.frame = CGRectMake(0,  bannerView.item.showingRow * 50, bannerView.item.viewWidth, 45);
            }
        }
    }];
}

#pragma mark - Getters
- (NSMutableArray *)waitingBannerItemArray {
    if (!_waitingBannerItemArray) {
        _waitingBannerItemArray = [NSMutableArray array];
    }
    return _waitingBannerItemArray;
}

- (NSMutableArray *)waitingbannerViewArray {
    if (!_waitingbannerViewArray) {
        _waitingbannerViewArray = [NSMutableArray array];
        // 创建3个ZTHLiveLoveBannerView
        for (int i = 0; i < 3; i++) {
            ZTHLiveLoveBannerView *bannerView = [[ZTHLiveLoveBannerView alloc] init];
            bannerView.frame = CGRectMake(-213, i * 50, 213, 45);
            [self.bannerContainerView addSubview:bannerView];
            [_waitingbannerViewArray addObject:bannerView];
        }
    }
    return _waitingbannerViewArray;
}

- (NSMutableArray *)showingBannerViewArray {
    if (!_showingBannerViewArray) {
        _showingBannerViewArray = [NSMutableArray array];
    }
    return _showingBannerViewArray;
}

- (UIView *)bannerContainerView {
    if (!_bannerContainerView) {
        _bannerContainerView = [[UIView alloc] init];
        _bannerContainerView.backgroundColor = [UIColor clearColor];
        _bannerContainerView.clipsToBounds = YES;
        _bannerContainerView.userInteractionEnabled = NO;
    }
    return _bannerContainerView;
}


@end
