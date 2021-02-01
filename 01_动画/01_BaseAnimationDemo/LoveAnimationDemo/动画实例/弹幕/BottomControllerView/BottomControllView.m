//
//  BottomControllView.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/19.
//

#import "BottomControllView.h"

@interface BottomControllView ()
/// 底部控件容器View
@property (nonatomic, strong) UIView *bottomContainerView;
/// 底部留言框
@property (nonatomic, strong) UIButton *bottomMessageButton;
/// 底部试看提示（或开通服务）
@property (nonatomic, strong) UIButton *bottomTryLookButton;
/// 底部邀请按钮
@property (nonatomic, strong) UIButton *bottomInvitationButton;
/// 底部礼包按钮
@property (nonatomic, strong) UIButton *bottomGiftButton;
/// 底部爱心按钮
@property (nonatomic, strong) UIButton *bottomLoveButton;
@end

@implementation BottomControllView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    [self addSubview:self.bottomContainerView];
    [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addSubview:self.bottomMessageButton];
    [self.bottomMessageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(230);
        make.height.mas_equalTo(36);
    }];
    
    [self addSubview:self.bottomTryLookButton];
    [self.bottomTryLookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomMessageButton.mas_right).offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(106);
        make.height.mas_equalTo(36);
    }];
    
    [self addSubview:self.bottomLoveButton];
    [self.bottomLoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-15);
    }];
    
    [self addSubview:self.bottomGiftButton];
    [self.bottomGiftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-65);
    }];
    
    [self addSubview:self.bottomInvitationButton];
    [self.bottomInvitationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(-115);
    }];
}

#pragma mark - Private
- (CAGradientLayer *)gradientWithBounds:(CGRect)bounds{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)UIColorFromRGBA(0x000000, 0).CGColor, (__bridge id)UIColorFromRGBA(0x000000, 0.25).CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    // 这里设置 垂直渐变
    gradientLayer.startPoint = CGPointMake(0.5 , 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

#pragma mark - Getter

- (UIView *)bottomContainerView {
    if (!_bottomContainerView) {
        _bottomContainerView = [[UIView alloc] init];
        [_bottomContainerView.layer addSublayer:[self gradientWithBounds:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)]];
    }
    return _bottomContainerView;
}

- (UIButton *)bottomMessageButton {
    if (!_bottomMessageButton) {
        _bottomMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomMessageButton.backgroundColor = UIColorFromRGBA(0x000000, 0.35);
        _bottomMessageButton.layer.cornerRadius = 18;
        [_bottomMessageButton setTitle:@"一起来留下你的留言吧～" forState:UIControlStateNormal];
        _bottomMessageButton.titleLabel.textColor = UIColorFromRGBA(0xFFFFFF, 0.8);
        _bottomMessageButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _bottomMessageButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        _bottomMessageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _bottomMessageButton;
}

- (UIButton *)bottomTryLookButton {
    if (!_bottomTryLookButton) {
        _bottomTryLookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomTryLookButton.backgroundColor = UIColorFromRGBA(0x000000, 0.85);
        _bottomTryLookButton.layer.cornerRadius = 18;
        [_bottomTryLookButton setTitle:@"可试看 3 次" forState:UIControlStateNormal];
        [_bottomTryLookButton setTitleColor:UIColorFromRGBV(0xECCF98) forState:UIControlStateNormal];
        _bottomTryLookButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _bottomTryLookButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _bottomTryLookButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _bottomTryLookButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_bottomTryLookButton setImage:[UIImage imageNamed:@"icon_vip"] forState:UIControlStateNormal];
        [_bottomTryLookButton setImage:[UIImage imageNamed:@"icon_vip"] forState:UIControlStateHighlighted];
    }
    return _bottomTryLookButton;
}

- (UIButton *)bottomLoveButton {
    if (!_bottomLoveButton) {
        _bottomLoveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomLoveButton setImage:[UIImage imageNamed:@"babyvideo_bottom_love"] forState:UIControlStateNormal];
        [_bottomLoveButton setImage:[UIImage imageNamed:@"babyvideo_bottom_love"] forState:UIControlStateHighlighted];
    }
    return _bottomLoveButton;
}

- (UIButton *)bottomGiftButton {
    if (!_bottomGiftButton) {
        _bottomGiftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomGiftButton setImage:[UIImage imageNamed:@"babyvideo_bottom_gift"] forState:UIControlStateNormal];
        [_bottomGiftButton setImage:[UIImage imageNamed:@"babyvideo_bottom_gift"] forState:UIControlStateHighlighted];
    }
    return _bottomGiftButton;
}

- (UIButton *)bottomInvitationButton {
    if (!_bottomInvitationButton) {
        _bottomInvitationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomInvitationButton setImage:[UIImage imageNamed:@"babyvideo_bottom_invite"] forState:UIControlStateNormal];
        [_bottomInvitationButton setImage:[UIImage imageNamed:@"babyvideo_bottom_invite"] forState:UIControlStateHighlighted];
    }
    return _bottomInvitationButton;
}




@end


