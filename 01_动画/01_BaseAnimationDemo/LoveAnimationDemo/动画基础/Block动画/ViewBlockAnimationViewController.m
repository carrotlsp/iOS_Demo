//
//  ViewBlockAnimationViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/28.
//

#import "ViewBlockAnimationViewController.h"

@interface ViewBlockAnimationViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, assign) CGPoint destinationPoint;

@end

@implementation ViewBlockAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.redView = [[UIView alloc] init];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.frame = CGRectMake(10, 50, 100, 100);
    [self.view addSubview:self.redView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self viewBlockAnimation_04];
}

- (void)viewBlockAnimation_01 {
    // actionForLayer:forKey 通过这个方法我们可以明白，为什么写在 block 外面不会触发动画，而写在 block 里面会触发动画
    NSLog(@"%@", [self.redView actionForLayer:self.redView.layer forKey:@"position"]);
    [UIView animateWithDuration:1.2  animations:^{
        self.redView.center = CGPointMake(200, 300);
        NSLog(@"%@", [self.redView actionForLayer:self.redView.layer forKey:@"position"]);
    } completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}

- (void)viewBlockAnimation_02 {
    // 思考 NSLog(@"Animating"); 什么时候被执行？会立刻执行
    [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.redView.center = CGPointMake(200, 300);
        NSLog(@"Animating");
    } completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}

- (void)viewBlockAnimation_03 {
    // finished立即被打印，然后 2s 后 view 会被瞬移到 CGPointMake(280, 280)
    [UIView animateWithDuration:2.0 animations:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.redView.center = CGPointMake(280, 280);
        });
    } completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}

- (void)viewBlockAnimation_04 {
    // dispatch_after在 2s 后被打印，再过 2s 会执行动画，最终 View 会移动到 CGPointMake(300, 300)的位置
    self.destinationPoint = CGPointMake(300, 300);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_after");
        self.destinationPoint = CGPointMake(-200, -200);
    });
    [UIView animateWithDuration:2.0 delay: 4.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.redView.center = self.destinationPoint;
        NSLog(@"Animating");
    } completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}

- (void)viewBlockAnimation_05 {
    [UIView animateKeyframesWithDuration:6.f
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0   // 相对于6秒所开始的时间（第0秒开始动画）
                                relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
            self.view.backgroundColor = [UIColor redColor];
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1/3.0 // 相对于6秒所开始的时间（第2秒开始动画）
                                relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
            self.view.backgroundColor = [UIColor yellowColor];
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 // 相对于6秒所开始的时间（第4秒开始动画）
                                relativeDuration:1/3.0 // 相对于6秒动画的持续时间（动画持续2秒）
                                      animations:^{
            self.view.backgroundColor = [UIColor greenColor];
        }];
        
    }
                              completion:^(BOOL finished) {
        NSLog(@"finished");
    }];
}



@end
