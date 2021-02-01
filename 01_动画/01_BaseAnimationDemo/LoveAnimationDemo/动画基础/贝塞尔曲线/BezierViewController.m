//
//  BezierViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import "BezierViewController.h"
#import "BezierView.h"

@interface BezierViewController ()
@property (nonatomic, strong) BezierView *bezierView;
@end

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.bezierView removeFromSuperview];
    
    self.bezierView = [[BezierView alloc] init];
    self.bezierView.frame = CGRectMake(10, 10, 100, 250);
    
//    self.bezierView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.bezierView];
    self.bezierView.backgroundColor = [UIColor lightGrayColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
