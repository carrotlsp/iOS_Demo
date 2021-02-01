//
//  WLikeAnimationView.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLikeAnimationView : UIView
+(instancetype)initWithStartingPoint:(CGPoint)point;
-(void)startAnimation;
@end

NS_ASSUME_NONNULL_END
