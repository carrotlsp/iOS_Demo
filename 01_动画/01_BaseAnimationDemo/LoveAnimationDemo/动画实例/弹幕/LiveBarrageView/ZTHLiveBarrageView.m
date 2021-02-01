//
//  ZTHLiveBarrageView.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import "ZTHLiveBarrageView.h"

@interface ZTHLiveBarrageView ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ZTHLiveBarrageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.layer.cornerRadius = 12;
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.right.mas_equalTo(0);
    }];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim {
//    NSLog(@"%s", __func__);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    NSLog(@"%s", __func__);
    if (self.animationDidStopBlock) {
        self.animationDidStopBlock();
    }
}

#pragma mark - Setter
- (void)setItem:(ZTHLiveBarrageItem *)item {
    _item = item;
    self.backgroundColor = UIColorFromRGBA(0xE5AB4C, 0.6);
    self.contentLabel.text = item.content;
}

#pragma mark - Getter
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}

@end
