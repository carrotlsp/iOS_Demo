//
//  SingleAnimationViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import "SingleAnimationViewController.h"

@interface SingleAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *rocketImageView;

@end

@implementation SingleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [self rocketBasicAnimation_05];
}

/// 动画结束会回到最初状态，我们没有改变 model layer的值，presentation layer是展示layer。
- (void)rocketBasicAnimation_01 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    baseAnimation.fromValue = @10;
    baseAnimation.toValue = @300;
    baseAnimation.duration = 1.0;
    [self.rocketImageView.layer addAnimation:baseAnimation forKey:@"baseAnimation"];
}

/// 对于上述问题，解决版本①手动将model layer的值设置成最终值
- (void)rocketBasicAnimation_02 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    baseAnimation.fromValue = @10;
    baseAnimation.toValue = @300;
    baseAnimation.duration = 1.0;
    [self.rocketImageView.layer addAnimation:baseAnimation forKey:@"baseAnimation"];
    
    self.rocketImageView.layer.position = CGPointMake(300, self.rocketImageView.layer.position.y);
}


/// 对于上述问题，解决版本②利用 fillMode 和 removedOnCompletion 来设置动画结束后，
/// fillMode 属性为 kCAFillModeForward 以留在最终状态
/// removedOnCompletion 为 NO 以防止它被自动移除
/// 缺点：如果将已完成的动画保持在 layer 上时，会造成额外的开销，因为渲染器会去进行额外的绘画工作。
- (void)rocketBasicAnimation_03 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    baseAnimation.fromValue = @10;
    baseAnimation.toValue = @300;
    baseAnimation.duration = 1.0;
    baseAnimation.fillMode = kCAFillModeForwards; // fillMode 属性为 kCAFillModeForward 以留在最终状态
    baseAnimation.removedOnCompletion = NO; // removedOnCompletion 为 NO 以防止它被自动移除
    [self.rocketImageView.layer addAnimation:baseAnimation forKey:@"baseAnimation"];
}

/// 值得指出的是，实际上我们创建的动画对象在被添加到 layer 时立刻就复制了一份。
/// 这个特性在多个 view 中重用动画时这非常有用。比方说我们想要第二个火箭在第一个火箭起飞不久后起飞：
- (void)rocketBasicAnimation_04 {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.byValue = @378;
    animation.duration = 1;

//    [rocket1.layer addAnimation:animation forKey:@"basic"];
//    rocket1.layer.position = CGPointMake(455, 61);

    animation.beginTime = CACurrentMediaTime() + 0.5;

//    [rocket2.layer addAnimation:animation forKey:@"basic"];
//    rocket2.layer.position = CGPointMake(455, 111);
}


/// byValue 的使用，让你无需关心之前的 fromValue 和 toValue
- (void)rocketBasicAnimation_05 {
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    baseAnimation.byValue = @100;
    baseAnimation.duration = 1.0;
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.removedOnCompletion = NO;
    [self.rocketImageView.layer addAnimation:baseAnimation forKey:@"baseAnimation"];
}

@end
