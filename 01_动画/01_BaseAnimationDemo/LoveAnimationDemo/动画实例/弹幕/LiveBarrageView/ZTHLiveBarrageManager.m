//
//  ZTHLiveBarrageManager.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import "ZTHLiveBarrageManager.h"

@interface ZTHLiveBarrageManager ()
/// 弹幕模型数组（等待展示）
@property (nonatomic, strong) NSMutableArray<ZTHLiveBarrageItem*> *barrageItemArray;
/// 弹幕视图数组
@property (nonatomic, strong) NSMutableArray<ZTHLiveBarrageView*> *barrageViewArray;
/// 弹幕轨道数组
@property (nonatomic, strong) NSMutableArray<ZTHLiveBarrageOrbit*> *barrageOrbitArray;
/// 弹幕容器
@property (nonatomic, strong) UIView *barrageContainerView;
/// 定时器（如果有带展示弹幕）
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZTHLiveBarrageManager

#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
}

- (void)setupTimer {
    __weak typeof(self) weakSelf = self;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.barrageItemArray.count > 0) { // 拿弹幕展示
            // 1.1 先获取能展示的轨道的视图
            ZTHLiveBarrageOrbit *resultOrbit = [weakSelf dequeueLeisureOrbit];
            if (resultOrbit == nil) {
                return; // 没有可以展示弹幕的轨道，终止此次流程
            }
            
            // 1.2 获取展示视图
            ZTHLiveBarrageItem *item = [weakSelf.barrageItemArray firstObject];
            if (item != nil) {
                [weakSelf.barrageItemArray removeObject:item];
            } else {
                return;
            }
            ZTHLiveBarrageView *view = [weakSelf dequeueBarrageView];
            view.item = item;
            
            // 1.3 将视图插入相应的轨道中
            [resultOrbit insertBarrage:view];
        } else { // 重新读取弹幕
            
        }
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

#pragma mark - Public Method
- (void)startBarrage {
    [self setupTimer];
    self.barrageContainerView.hidden = NO;
}

- (void)stopBarrage {
    [self.timer invalidate];
    self.timer = nil;
    self.barrageContainerView.hidden = YES;
}

- (void)insertBarrageItem:(ZTHLiveBarrageItem *)barrageItem {
    [self.barrageItemArray insertObject:barrageItem atIndex:0];
}

- (void)refreshBarrageItemByArray:(NSArray<ZTHLiveBarrageItem*> *)barrageItemArray {
    [self.barrageItemArray removeAllObjects];
    [self.barrageItemArray addObjectsFromArray:barrageItemArray];
}

#pragma mark - Private Method
/// 获取空闲状态的轨道
- (ZTHLiveBarrageOrbit*)dequeueLeisureOrbit {
    ZTHLiveBarrageOrbit *resultOrbit = nil;
    for (ZTHLiveBarrageOrbit *orbit in self.barrageOrbitArray) {
        if (orbit.isLeisure) {
            resultOrbit = orbit;
            break;
        }
    }
    return resultOrbit;
}

/// 从缓存池子中取视图
- (ZTHLiveBarrageView*)dequeueBarrageView {
    ZTHLiveBarrageView *barrageView = [self.barrageViewArray firstObject];
    if (barrageView != nil) {
        [self.barrageViewArray removeObject:barrageView];
    } else {
        barrageView = [[ZTHLiveBarrageView alloc] init];
        [self.barrageContainerView addSubview:barrageView];
    }
    return barrageView;
}

#pragma mark - Getter

- (UIView *)barrageContainerView {
    if (!_barrageContainerView) {
        _barrageContainerView = [[UIView alloc] init];
        _barrageContainerView.layer.borderWidth = 1;
        _barrageContainerView.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    return _barrageContainerView;
}

- (NSMutableArray<ZTHLiveBarrageItem *> *)barrageItemArray {
    if (!_barrageItemArray) {
        _barrageItemArray = [NSMutableArray array];
        [self mockBarrageItems];
    }
    return _barrageItemArray;
}

- (NSMutableArray<ZTHLiveBarrageView *> *)barrageViewArray {
    if (!_barrageViewArray) {
        _barrageViewArray = [NSMutableArray array];
    }
    return _barrageViewArray;
}

- (NSMutableArray<ZTHLiveBarrageOrbit *> *)barrageOrbitArray {
    if (!_barrageOrbitArray) {
        _barrageOrbitArray = [NSMutableArray array];
        
        /// 初始化两个轨道
        __weak typeof(self) weakSelf = self;
        {
            ZTHLiveBarrageOrbit *barrageOrbit = [[ZTHLiveBarrageOrbit alloc] init];
            barrageOrbit.barrageFrame = CGRectMake(0, 10, self.barrageContainerView.bounds.size.width, self.barrageContainerView.bounds.size.height);
            [_barrageOrbitArray addObject:barrageOrbit];
            barrageOrbit.animationDidStopBlock = ^(ZTHLiveBarrageView * _Nonnull barrageView) {
                [weakSelf.barrageViewArray addObject:barrageView];
            };
        }
        {
            ZTHLiveBarrageOrbit *barrageOrbit = [[ZTHLiveBarrageOrbit alloc] init];
            barrageOrbit.barrageFrame = CGRectMake(0, 54, self.barrageContainerView.bounds.size.width, self.barrageContainerView.bounds.size.height);
            [_barrageOrbitArray addObject:barrageOrbit];
            barrageOrbit.animationDidStopBlock = ^(ZTHLiveBarrageView * _Nonnull barrageView) {
                [weakSelf.barrageViewArray addObject:barrageView];
            };
        }
    }
    return _barrageOrbitArray;
}

#pragma mark - Mock

- (void)mockBarrageItems {
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0xE5AB4C";
        item.content = @"1张三奶奶留言：宝宝今天在学校的表现很棒哦～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0x000000";
        item.content = @"2李四奶奶留言：宝贝今天有进步啦～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0xE5AB4C";
        item.content = @"3王五奶奶留言：老师您辛苦了～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0x000000";
        item.content = @"4王珂妮奶奶留言：老师指导的很好哦～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0xE5AB4C";
        item.content = @"5赵柳妈妈送出了爱心，关爱值+10～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0x000000";
        item.content = @"6李琦妈妈送出了爱心，关爱值+10～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0xE5AB4C";
        item.content = @"7王诗雨妈妈送出了爱心，关爱值+10～";
        [self.barrageItemArray addObject:item];
    }
    {
        ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
        item.backgroundColor = @"0x000000";
        item.content = @"8邓紫棋妈妈送出了爱心，关爱值+10～";
        [self.barrageItemArray addObject:item];
    }
}

@end
