//
//  ZTHLiveBarrageManager.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZTHLiveBarrageItem.h"
#import "ZTHLiveBarrageView.h"
#import "ZTHLiveBarrageOrbit.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZTHLiveBarrageManager : NSObject
/// 弹幕容器
@property (nonatomic, strong, readonly) UIView *barrageContainerView;
/// 开始展示弹幕
- (void)startBarrage;
/// 停止展示弹幕
- (void)stopBarrage;
/// 插入新弹幕
- (void)insertBarrageItem:(ZTHLiveBarrageItem*)barrageItem;
/// 根据barrageItemArray刷新弹幕展示的数组
- (void)refreshBarrageItemByArray:(NSArray<ZTHLiveBarrageItem*> *)barrageItemArray;
@end

NS_ASSUME_NONNULL_END
