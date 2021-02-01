//
//  ZTHLiveBarrageItem.h
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTHLiveBarrageItem : NSObject

/// 弹幕颜色
@property (nonatomic, strong) NSString *color;
/// 弹幕背景颜色
@property (nonatomic, strong) NSString *backgroundColor;
/// 弹幕内容
@property (nonatomic, strong) NSString *content;
/// 弹幕类型
@property (nonatomic, strong) NSString *type;
/// 弹幕文本长度
@property (nonatomic, assign) CGFloat contentLength;
/// 弹幕的开始位置
//@property (nonatomic, assign) CGFloat fromPositionX;
/// 弹幕的结束位置
@property (nonatomic, assign) CGFloat toPositionX;

@end

NS_ASSUME_NONNULL_END
