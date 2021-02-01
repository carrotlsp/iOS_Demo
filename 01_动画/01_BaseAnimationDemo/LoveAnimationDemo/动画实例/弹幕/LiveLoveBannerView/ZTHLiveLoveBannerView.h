//
//  ZTHLiveLoveBannerView.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import <UIKit/UIKit.h>
#import "ZTHLiveLoveBannerView.h"
#import "ZTHLiveLoveBannerItem.h"

/// 横幅默认宽度
#define LiveLoveBannerViewWidth 213
/// 横幅默认高度
#define LiveLoveBannerViewHeight 45
/// 横幅之间默认间隔
#define LiveLoveBannerViewMargin 5

@interface ZTHLiveLoveBannerView : UIView

@property (nonatomic, strong) ZTHLiveLoveBannerItem *item;

/// 播放展示动画
- (void)showingView;

/// 播放展示数字增加的动画
- (void)showingAddNumberAnimation;

/// 重启定时器（默认3s后会播放隐藏动画）
- (void)restartTimer;

@end


