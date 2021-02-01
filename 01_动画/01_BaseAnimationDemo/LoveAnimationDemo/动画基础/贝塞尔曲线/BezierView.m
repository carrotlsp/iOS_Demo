//
//  BezierView.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import "BezierView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define kLineW ScreenWidth-10*2
#define kMargin 10

@implementation BezierView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self draw_14:rect];
        
}

/// 1. 绘制一条直线,即一次贝塞尔曲线
- (void)draw_01:(CGRect)rect {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 1.f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    path.miterLimit = 10.f;
    path.flatness = 10.f;
    path.usesEvenOddFillRule = YES;
    // 设置起始点
    [path moveToPoint:CGPointMake(kMargin, kMargin)];
    // 添加子路径
    [path addLineToPoint:CGPointMake(kLineW, kMargin)];//添加一条子路径
    // 根据坐标点连线
    [path stroke];
}

/// 11.绘制三次贝塞尔曲线(横线)
- (void)draw_11:(CGRect)rect {
    UIBezierPath *path10 = [UIBezierPath bezierPath];
//    [path10 moveToPoint:CGPointMake(50, 550)];
    [path10 addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(150, 450) controlPoint2:CGPointMake(250, 600)];
    [path10 stroke];
}

/// 12.绘制三次贝塞尔曲线(横线)
- (void)draw_12:(CGRect)rect {
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    UIBezierPath *path10 = [UIBezierPath bezierPath];
    [path10 moveToPoint:CGPointMake(width / 2.0, height)];
    [path10 addCurveToPoint:CGPointMake(width / 2.0, 0) controlPoint1:CGPointMake( width / 2 + width *1.5, height / 3 * 2) controlPoint2:CGPointMake(  width / 2 - width *1.5, height / 3 * 1)];
    
    [path10 stroke];
}

/// 13.绘制三次贝塞尔曲线(横线会抖动)
- (void)draw_13:(CGRect)rect {
    
    
    // 随机生成正负两个方向
    BOOL isNagative = arc4random_uniform(2) % 2;
    // 生成随机生成点的比例 0.7 ~ 1.5
    CGFloat widthScale =  (arc4random_uniform(800) + 700) / 1000.0;
    // 生成随机生成顶点的比例 0 ~ 1.0
    CGFloat topWidthScale =  arc4random_uniform(10000) / 10000.0;
    NSLog(@" %i, %f, %f",isNagative, widthScale, topWidthScale);
    
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    UIBezierPath *path10 = [UIBezierPath bezierPath];
    [path10 moveToPoint:CGPointMake(width / 2.0, height)];
    if (isNagative) {
        [path10 addCurveToPoint:CGPointMake(width / 2, 0) controlPoint1:CGPointMake( width / 2 + width *1.5, height / 3 * 2) controlPoint2:CGPointMake(  width / 2 - width *1.5, height / 3 * 1)];
    } else {
        [path10 addCurveToPoint:CGPointMake(width / 2, 0) controlPoint1:CGPointMake( width / 2 - width * 1.5 , height / 3  * 2) controlPoint2:CGPointMake( width / 2 + width * 1.5 , height / 3 )];
    }
    
    
    [path10 stroke];
}

/// 14.绘制三次贝塞尔曲线(横线会抖动 + 系数)
- (void)draw_14:(CGRect)rect {
    
    // 随机生成正负两个方向
    BOOL isNagative = arc4random_uniform(2) % 2;
    // 生成随机生成宽度的比例 0.7 ~ 1.5
    CGFloat widthPercentage =  (arc4random_uniform(800) + 700) / 1000.0;
    // 生成随机生成顶点 X 轴的的比例 0 ~ 1.0
    CGFloat endPointXPercentage =  arc4random_uniform(10000) / 10000.0;
    NSLog(@" %i, %f, %f",isNagative, widthPercentage, endPointXPercentage);
    
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(width / 2.0, height)];
    if (isNagative) {
        [bezierPath addCurveToPoint:CGPointMake(width * endPointXPercentage, 0) controlPoint1:CGPointMake(width / 2 + width * widthPercentage, height / 3 * 2) controlPoint2:CGPointMake(width / 2 - width * widthPercentage, height / 3)];
    } else {
        [bezierPath addCurveToPoint:CGPointMake(width * endPointXPercentage, 0) controlPoint1:CGPointMake(width / 2 - width * widthPercentage , height / 3  * 2) controlPoint2:CGPointMake(width / 2 + width * widthPercentage , height / 3)];
    }
    
    [bezierPath stroke];
}

@end
