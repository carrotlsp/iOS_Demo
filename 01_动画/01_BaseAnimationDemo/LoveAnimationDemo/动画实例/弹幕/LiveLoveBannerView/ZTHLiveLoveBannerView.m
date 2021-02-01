//
//  ZTHLiveLoveBannerView.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import "ZTHLiveLoveBannerView.h"

@interface ZTHLiveLoveBannerView ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UIImageView *loveImageView;
@property (nonatomic, strong) UILabel *loveCountLabel;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation ZTHLiveLoveBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.layer.cornerRadius = 22.5;
    self.layer.masksToBounds = YES;
    
    self.gradientLayer = [self gradientWithBounds:CGRectMake(0, 0, 213, 45)];
    [self.layer addSublayer:self.gradientLayer];
    
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.height.width.mas_equalTo(35);
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:self.nicknameLabel];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(46);
        make.top.mas_equalTo(8);
        make.height.mas_equalTo(14);
    }];
    
    [self addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(46);
        make.bottom.mas_equalTo(-7);
        make.height.mas_equalTo(11);
    }];
    
    [self addSubview:self.loveCountLabel];
    [self.loveCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(40);
    }];
    
    [self addSubview:self.loveImageView];
    [self.loveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-52);
        make.height.width.mas_equalTo(35);
        make.centerY.mas_equalTo(self);
    }];
}

#pragma mark - Public Method
- (void)showingView {
        self.item.bannerViewState = LiveLoveBannerViewStateShowing;
    [self restartTimer];
    
//    CGFloat fromFrameX = self.frame.origin.x;
//    CGFloat toFrameX = self.frame.origin.x + self.frame.size.width;
//    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
//    baseAnimation.fromValue = @(fromFrameX);
//    baseAnimation.toValue = @(toFrameX);
//    baseAnimation.duration = 0.3;
//    baseAnimation.fillMode = kCAFillModeForwards;
//    baseAnimation.removedOnCompletion = NO;
//    [self.layer addAnimation:baseAnimation forKey:@"baseAnimation"];
//    self.item.bannerViewState = LiveLoveBannerViewStateShowing;
//    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.frame.origin.x = toFrameX;
//    } completion:^(BOOL finished) {
//        self.frame.origin.x = toFrameX;
//        self.item.bannerViewState = LiveLoveBannerViewStateShowed;
//        [self restartTimer];
//        if (self.item.bannerViewStateChangeBlock) {
//            self.item.bannerViewStateChangeBlock(self);
//        }
//    }];
}
/// 重启定时器
- (void)restartTimer {
    [self stopTimer];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf hidingView];
    }];
};

- (void)showingAddNumberAnimation {
    self.item.loveCount += 1;
    if (self.item.loveCount >= 99) {
        self.item.loveCount = 99;
    }
    self.loveCountLabel.text = [NSString stringWithFormat:@"X%i",self.item.loveCount];
    
    if (self.item.loveCount >= 10) {
        self.loveCountLabel.textAlignment = NSTextAlignmentRight;
    } else {
        self.loveCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    // 刷新定时器
    [self restartTimer];
    // 缩放动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.keyTimes = @[@(0), @(1.0)];
    animation.values = @[@(1.8), @(1.0)];
    animation.duration = 0.2;
    [self.loveCountLabel.layer addAnimation:animation forKey:@"scale"];
}

#pragma mark - Private Method
/// 播放隐藏动画
- (void)hidingView {
    CGRect fromFrame = self.frame;
    CGRect toFrame = CGRectMake(fromFrame.origin.x - fromFrame.size.width, fromFrame.origin.y, fromFrame.size.width, fromFrame.size.height);
    self.item.bannerViewState = LiveLoveBannerViewStateHiding;
    if (self.item.bannerViewStateChangeBlock) {
        self.item.bannerViewStateChangeBlock(self);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = toFrame;
    } completion:^(BOOL finished) {
        self.frame = toFrame;
        self.item.bannerViewState = LiveLoveBannerViewStateHidden;
        if (self.item.bannerViewStateChangeBlock) {
            self.item.bannerViewStateChangeBlock(self);
        }
    }];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (CAGradientLayer *)gradientWithBounds:(CGRect)bounds{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)UIColorFromRGBV(0x8058F4).CGColor, (__bridge id)UIColorFromRGBV(0xEB61CF).CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    // 这里设置 水平渐变
    gradientLayer.startPoint = CGPointMake(0 , 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    gradientLayer.cornerRadius = 22.5;
    return gradientLayer;
}

#pragma mark - Getters Setters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
        _avatarImageView.layer.cornerRadius = 17.5;
        _avatarImageView.clipsToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc] init];
        _nicknameLabel.textColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:14];
        _nicknameLabel.text = @"王珂的妈妈";
    }
    return _nicknameLabel;
}

- (UILabel *)remarkLabel {
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc] init];
        _remarkLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
        _remarkLabel.font = [UIFont systemFontOfSize:12];
        _remarkLabel.text = @"送出爱心";
    }
    return _remarkLabel;
}

- (UIImageView *)loveImageView {
    if (!_loveImageView) {
        _loveImageView = [[UIImageView alloc] init];
        _loveImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"babyvideo_banner_love"]];
        _loveImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _loveImageView;
}

- (UILabel *)loveCountLabel {
    if (!_loveCountLabel) {
        _loveCountLabel = [[UILabel alloc] init];
        _loveCountLabel.textColor = [UIColor whiteColor];
        _loveCountLabel.font = [UIFont boldSystemFontOfSize:20];
        _loveCountLabel.text = @"X1";
        _loveCountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _loveCountLabel;
}

- (void)setItem:(ZTHLiveLoveBannerItem *)item {
    _item = item;
    self.nicknameLabel.text = item.nickname;
    if (item.loveCount > 99) {
        item.loveCount = 99;
    }
    self.loveCountLabel.text = [NSString stringWithFormat:@"X%i",item.loveCount];
    [self.avatarImageView setImage:[UIImage imageNamed: @"live_banner_live_avatar"]];
    
    if (item.avatarURL.length > 0) {
        NSString *placeString = @"live_banner_live_avatar";
        UIImage *placeHolderImage =[UIImage imageNamed:placeString];
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:item.avatarURL] placeholderImage:placeHolderImage];
    }
    
    
    [self.nicknameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.item.nicknameWidth);
    }];
    
    // 背景 213 - 70 = 143
    self.gradientLayer.frame = CGRectMake(0, 0, self.item.viewWidth, 45);
}

@end
