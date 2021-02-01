//
//  ZTHLiveLoveBannerManager.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import <Foundation/Foundation.h>
#import "ZTHLiveLoveBannerView.h"

@interface ZTHLiveLoveBannerManager : NSObject

/// 横幅视图容器
@property (nonatomic, strong, readonly) UIView *bannerContainerView;
/// 是否能展示横幅弹幕（默认不行，需优先进行配置）
@property (nonatomic, assign) BOOL isCanShowBannerBarrage;

/// 添加横幅数据
- (void)pushBannerItem:(ZTHLiveLoveBannerItem*)item;
@end

