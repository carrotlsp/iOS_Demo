//
//  BarrageViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import "BarrageViewController.h"
#import "AppDelegate.h"
#import "ZTHLiveBarrageManager.h"
#import "BottomControllView.h"

@interface BarrageViewController ()
@property (nonatomic, strong) ZTHLiveBarrageManager *barrageManager;
@end

@implementation BarrageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    [self setNewOrientation:YES];//调用转屏代码
    
//    HorizontalBg
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"videoBg"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.barrageManager.barrageContainerView];
    [self.barrageManager.barrageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(50);
        make.height.mas_equalTo (88);
    }];
    
    // button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"增加留言" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(addBarrage) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(44);
    }];
    
    // BottomControllView
    BottomControllView *bottomView = [[BottomControllView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
}

- (void)addBarrage {
    ZTHLiveBarrageItem *item = [[ZTHLiveBarrageItem alloc] init];
    item.backgroundColor = @"0xE5AB4C";
    int randomVale = arc4random();
    item.content = [NSString stringWithFormat:@"新增消息送出了爱心，关爱值+%i～", randomVale];
    [self.barrageManager insertBarrageItem:item];
    NSLog(@"%@",item.content);
}

- (void)setNewOrientation:(BOOL)fullscreen{
    if (fullscreen) {
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }else{
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    [self setNewOrientation:NO];
}

#pragma mark - Getter
- (ZTHLiveBarrageManager *)barrageManager {
    if (!_barrageManager) {
        _barrageManager = [[ZTHLiveBarrageManager alloc] init];
        [_barrageManager startBarrage];
    }
    return _barrageManager;
}

@end
