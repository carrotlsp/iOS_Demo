//
//  ZTHLiveBarrageOrbit.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import "ZTHLiveBarrageOrbit.h"

@interface ZTHLiveBarrageOrbit ()

/// 弹幕视图数组
@property (nonatomic, strong) NSMutableArray<ZTHLiveBarrageView*> *barrageViewArray;
/// 轨道中弹幕速度
@property (nonatomic, assign) NSInteger barrageSpeed;

@end

@implementation ZTHLiveBarrageOrbit
#pragma mark - Public Mehtod
- (BOOL)isLeisure {
//    [weakSelf.testView.layer presentationLayer].position
    ZTHLiveBarrageView *lastBarrageView = [self.barrageViewArray lastObject];
    if (lastBarrageView == nil) { // 轨道没有在展示的弹幕
        return YES;
    } else {
        // 本轨道的最后一个弹幕，现在走到哪个位置了
        CGPoint point = [lastBarrageView.layer presentationLayer].position;
        CGFloat currentTailX = point.x + lastBarrageView.item.contentLength;
        CGFloat allowShowDistance = self.barrageSpeed * 1.5;
        BOOL canShow = (self.barrageFrame.size.width - currentTailX) > allowShowDistance ? YES : NO;
        return canShow;
    }
}

- (void)insertBarrage:(ZTHLiveBarrageView *)barrageView {
    [self.barrageViewArray addObject:barrageView];
    [self startAnimation:barrageView];
}

#pragma mark - Private Mehtod
- (void)startAnimation:(ZTHLiveBarrageView *)barrageView {
    /// 1.创建动画，并且让barrageView执行动画
    [barrageView.layer removeAllAnimations];
    barrageView.frame = CGRectMake(self.barrageFrame.size.width, self.barrageFrame.origin.y, barrageView.item.contentLength, 24);
    barrageView.layer.anchorPoint = CGPointMake(0, 0.5);
    CABasicAnimation *moveAnimation = [CABasicAnimation animation];
    moveAnimation.keyPath = @"position.x";
    moveAnimation.beginTime = CACurrentMediaTime() + 1.0;
    moveAnimation.fromValue = @(self.barrageFrame.size.width);
    moveAnimation.toValue = @(barrageView.item.toPositionX);
    CGFloat animationDuration = (barrageView.item.contentLength + self.barrageFrame.size.width) / self.barrageSpeed;
    moveAnimation.duration = animationDuration;
    moveAnimation.delegate = barrageView;
    [barrageView.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    /// 2.监听动画结束
    [self.barrageViewArray addObject:barrageView];
    __weak typeof(barrageView) weakBarrageView = barrageView;
    __weak typeof(self) weakSelf = self;
    barrageView.animationDidStopBlock = ^{
        [weakSelf.barrageViewArray removeObject:weakBarrageView];
        if (weakSelf.animationDidStopBlock) {
            weakSelf.animationDidStopBlock(weakBarrageView);
        }
    };
}

#pragma mark - Getter
- (NSInteger)barrageSpeed {
    if (!_barrageSpeed) {
        _barrageSpeed = self.barrageFrame.size.width / 8.0;
    }
    return _barrageSpeed;
}

- (NSMutableArray<ZTHLiveBarrageView *> *)barrageViewArray {
    if (!_barrageViewArray) {
        _barrageViewArray = [NSMutableArray array];
    }
    return _barrageViewArray;
}

@end
