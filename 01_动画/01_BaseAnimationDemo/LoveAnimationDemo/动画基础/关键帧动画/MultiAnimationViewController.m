//
//  MultiAnimationViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import "MultiAnimationViewController.h"

@interface MultiAnimationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIImageView *rocketImageView;

@property (weak, nonatomic) IBOutlet UIView *cycleView;

@end

@implementation MultiAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cycleView.layer.cornerRadius = 100;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testPathAnimation];
}



/// 路径动画
- (void)testPathAnimation {
    
    self.rocketImageView.center = self.cycleView.center;
    
    CGRect boundingRect = CGRectMake(-150, -150, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    /// 使用 CGPathCreateWithEllipseInRect()，我们创建一个圆形的 CGPath 作为我们的关键帧动画的 path。
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    /// 连续动画必须要设置为YES，让下一个动画，基于上一个动画
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    /// 使用 calculationMode 是控制关键帧动画时间的另一种方法。
    /// 我们通过将其设置为 kCAAnimationPaced，让 Core Animation 向被驱动的对象施加一个恒定速度，
    /// 不管路径的各个线段有多长。将其设置为 kCAAnimationPaced 将无视所有我们已经设置的 keyTimes。
    orbit.calculationMode = kCAAnimationPaced;
    /// 设置 rotationMode 属性为 kCAAnimationRotateAuto 确保飞船沿着路径旋转。
    /// 作为对比，如果我们将该属性设置为 nil 那动画会是什么样的呢。
    orbit.rotationMode = kCAAnimationRotateAuto;
//    orbit.rotationMode = nil;
    [self.rocketImageView.layer addAnimation:orbit forKey:@"orbit"];
}

/// 仿苹果输入密码错误，输入框抖动的效果
- (void)testTestFieldAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[@0, @10, @-10, @0];
    animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
    animation.duration = 1.4;
    /// 连续动画必须要设置为YES，让下一个动画，基于上一个动画
    animation.additive = YES;
    [self.textField.layer addAnimation:animation forKey:@"shake"];
}


@end
