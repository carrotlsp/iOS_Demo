//
//  ZTHLiveLoveBannerItem.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/20.
//

#import "ZTHLiveLoveBannerItem.h"

@implementation ZTHLiveLoveBannerItem

- (int)loveCount {
    if (!_loveCount) {
        _loveCount = 1;
    }
    return _loveCount;
}

- (int)nicknameWidth {
    if (_nicknameWidth <= 0) {
        _nicknameWidth = [self.nickname boundingRectWithSize:CGSizeMake(1000, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width + 2;
        
        CGFloat maxWidth = SCREEN_WIDTH * 0.43;
        if (_nicknameWidth > maxWidth) {
            _nicknameWidth = maxWidth;
        }
    }
    return _nicknameWidth;
}

- (int)viewWidth {
    if (_viewWidth <= 0) {
        _viewWidth = 141 + self.nicknameWidth;
    }
    return _viewWidth;
}

@end
