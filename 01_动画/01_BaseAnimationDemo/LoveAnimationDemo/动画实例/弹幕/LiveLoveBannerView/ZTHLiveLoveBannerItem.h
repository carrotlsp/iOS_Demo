//
//  ZTHLiveLoveBannerItem.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import <Foundation/Foundation.h>

@class ZTHLiveLoveBannerView;
typedef NS_ENUM(NSUInteger, LiveLoveBannerViewState) {
    /// 正在等待展示
    LiveLoveBannerViewStateWaitting,
    /// 正在（进行动画）展示
    LiveLoveBannerViewStateShowing,
    /// 已经展示
    LiveLoveBannerViewStateShowed,
    /// 正在（进行动画）隐藏
    LiveLoveBannerViewStateHiding,
    /// 已经隐藏
    LiveLoveBannerViewStateHidden,
};

@interface ZTHLiveLoveBannerItem : NSObject
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *avatarURL; /// 头像地址（只有是自己发送的爱心赞才会有）
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) int loveCount;
// 下面参数是计算值
@property (nonatomic, assign) int viewWidth;
@property (nonatomic, assign) int nicknameWidth;
@property (nonatomic, assign) int showingRow;          /// 所属的行
/// bannerView的状态
@property (nonatomic, assign) LiveLoveBannerViewState bannerViewState;
/// bannerView的状态变更回调（返回变更后的状态）
@property (nonatomic, copy) void(^bannerViewStateChangeBlock)(ZTHLiveLoveBannerView *bannerView);
@end

