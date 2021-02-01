//
//  LiveBannerViewController.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import "LiveBannerViewController.h"
#import "ZTHLiveLoveBannerManager.h"
#import "TestView.h"

@interface LiveBannerViewController ()
@property (nonatomic, strong)ZTHLiveLoveBannerManager *bannerManager;
@end

@implementation LiveBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.bannerManager = [[ZTHLiveLoveBannerManager alloc] init];
    
    [self.view addSubview:self.bannerManager.bannerContainerView];
    self.bannerManager.isCanShowBannerBarrage = YES;
    self.bannerManager.bannerContainerView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    [self.bannerManager.bannerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(145);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.view);
    }];
}

- (IBAction)yeye:(id)sender {
    ZTHLiveLoveBannerItem *item = [[ZTHLiveLoveBannerItem alloc] init];
    item.userId = @"yeye";
    item.nickname = @"王珂的王珂爷爷";
    item.remark = @"送出爱心";
    item.loveCount = 1;
    
    [self.bannerManager pushBannerItem:item];
}

- (IBAction)nainai:(id)sender {
    
    ZTHLiveLoveBannerItem *item = [[ZTHLiveLoveBannerItem alloc] init];
    item.userId = @"nainai";
    item.nickname = @"王珂王珂王珂的王珂王珂王珂奶奶";
    item.remark = @"送出爱心";
    item.loveCount = 1;
    
    [self.bannerManager pushBannerItem:item];
}

- (IBAction)baba:(id)sender {
    
    ZTHLiveLoveBannerItem *item = [[ZTHLiveLoveBannerItem alloc] init];
    item.userId = @"baba";
    item.nickname = @"王爸爸";
    item.remark = @"送出爱心";
    item.loveCount = 1;

    [self.bannerManager pushBannerItem:item];
}

- (IBAction)mama:(id)sender {
    ZTHLiveLoveBannerItem *item = [[ZTHLiveLoveBannerItem alloc] init];
    item.userId = @"mama";
    item.nickname = @"王珂的妈妈";
    item.remark = @"送出爱心";
    item.loveCount = 1;

    [self.bannerManager pushBannerItem:item];
    
}

- (IBAction)randomOne:(id)sender {
    int random = arc4random() % 5 + 2;
    for (int i = 0; i < 10; i++) {
        ZTHLiveLoveBannerItem *item = [[ZTHLiveLoveBannerItem alloc] init];
        item.userId = [NSString stringWithFormat:@"%i",random];
        item.nickname = [NSString stringWithFormat:@"重复%i",random];
        item.remark = @"送出爱心";
        item.loveCount = 1;
        [self.bannerManager pushBannerItem:item];
    }
}

- (IBAction)randomMore:(id)sender {
    int count = arc4random() % 5 + 2;
    for (int i = 0; i < count; i++) {
        ZTHLiveLoveBannerItem *item = [[ZTHLiveLoveBannerItem alloc] init];
        item.userId = [NSString stringWithFormat:@"%i",arc4random()];
        item.nickname = [NSString stringWithFormat:@"几条%i",arc4random()];
        item.remark = @"送出爱心";
        item.loveCount = 1;

        [self.bannerManager pushBannerItem:item];
    }
}


- (void)testCode {
    //    TestView *testView = [[TestView alloc] init];
    //    testView.frame = CGRectMake(10, 10, 30, 30);
    //    testView.backgroundColor = [UIColor redColor];
    //    [self.bannerManager.bannerContainerView addSubview:testView];
    //    testView.bannerViewStateChangeBlock = ^(TestView * _Nonnull testView) {
    //        testView.backgroundColor = [UIColor yellowColor];
    //    };
    
    
    
//    [[self.bannerManager.bannerContainerView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
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
