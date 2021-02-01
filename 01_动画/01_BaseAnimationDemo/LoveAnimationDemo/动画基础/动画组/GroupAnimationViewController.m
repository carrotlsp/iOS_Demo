//
//  GroupAnimationViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@end

@implementation GroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    [self groupAnimation];
}

- (void)groupAnimation {
    CABasicAnimation *zPositon = [CABasicAnimation animation];
    zPositon.keyPath = @"zPosition";
    zPositon.fromValue = @-1;
    zPositon.toValue = @1;
    zPositon.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[@0, @0.14, @0];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
    ];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
        [NSValue valueWithCGPoint:CGPointZero],
        [NSValue valueWithCGPoint:CGPointMake(110, -20)],
        [NSValue valueWithCGPoint:CGPointZero]
    ];
    position.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[zPositon, rotation, position];
    group.duration = 1.2;
//    group.beginTime = 0.5;
    
    [self.oneImageView.layer addAnimation:group forKey:@"shuffle"];
    
    self.oneImageView.layer.zPosition = 1;
}

@end
