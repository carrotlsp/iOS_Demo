//
//  ZTHLiveBarrageView.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import <UIKit/UIKit.h>
#import "ZTHLiveBarrageItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZTHLiveBarrageView : UIView <CAAnimationDelegate>

/// 弹幕模型
@property (nonatomic, strong) ZTHLiveBarrageItem *item;
/// 动画执行完毕的回调
@property (nonatomic, copy) void(^animationDidStopBlock)(void);

@end

NS_ASSUME_NONNULL_END
