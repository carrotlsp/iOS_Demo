//
//  TestView.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestView : UIView

@property (nonatomic, copy) void(^bannerViewStateChangeBlock)(TestView *testView);

@end

NS_ASSUME_NONNULL_END
