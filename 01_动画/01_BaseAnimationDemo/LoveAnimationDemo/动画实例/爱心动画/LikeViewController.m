#import "LikeViewController.h"
#import "WLikeAnimationView.h"
#import "WLikeAnimationView_New.h"

@interface LikeViewController ()
@property(nonatomic,strong) WLikeAnimationView *likeAnimationView;
@property(nonatomic,strong) WLikeAnimationView_New *likeAnimationView_new;
@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 40, 40)];
//    button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.likeAnimationView = [WLikeAnimationView initWithStartingPoint:CGPointMake(60, 500)];
    [self.view addSubview:self.likeAnimationView];
    
    
    self.likeAnimationView_new = [[WLikeAnimationView_New alloc] init];
    self.likeAnimationView_new.frame = CGRectMake(200 + 20 , 250, 100, 250);
    [self.view addSubview:self.likeAnimationView_new];
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(260, 500, 40, 40)];
    [button2 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"button"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}


-(void)buttonClicked{
    NSLog(@"%s", __func__);
    [self.likeAnimationView startAnimation];
    
    

}

-(void)button2Clicked:(UIButton*)btn{
//    NSLog(@"%s", __func__);
    
    // 缩放动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.keyTimes = @[@(0), @(1.0)];
    animation.values = @[@(0.7), @(1.0)];
    animation.duration = 0.2;
    [btn.layer addAnimation:animation forKey:@"scale"];
    [self.likeAnimationView_new startAnimationOnce];
}
@end
