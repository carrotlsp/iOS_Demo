//
//  ZTHLiveBarrageOrbit.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import "ZTHLiveBarrageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZTHLiveBarrageOrbit : NSObject

/// 轨道中弹幕高度
@property (nonatomic, assign) CGRect barrageFrame;
/// 轨道是否处于空闲（即可以加入新弹幕）
- (BOOL)isLeisure;
/// 插入新弹幕
- (void)insertBarrage:(ZTHLiveBarrageView*)barrageView;
/// 动画执行完毕的回调
@property (nonatomic, copy) void(^animationDidStopBlock)(ZTHLiveBarrageView *view);

@end

NS_ASSUME_NONNULL_END
