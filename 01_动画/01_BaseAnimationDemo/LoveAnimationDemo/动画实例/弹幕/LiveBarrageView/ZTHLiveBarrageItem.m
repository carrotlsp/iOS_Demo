//
//  ZTHLiveBarrageItem.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/15.
//

#import "ZTHLiveBarrageItem.h"

@implementation ZTHLiveBarrageItem

- (CGFloat)contentLength {
    if (!_contentLength) {
        _contentLength = [self.content boundingRectWithSize:CGSizeMake(1000, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
        // 给label加一个20的padding
        _contentLength += 20;
    }
    return _contentLength;
}

- (CGFloat)fromPositionX {
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)toPositionX {
    return -(self.contentLength + 20);
}

@end
