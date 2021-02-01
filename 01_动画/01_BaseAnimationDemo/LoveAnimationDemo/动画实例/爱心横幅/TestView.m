//
//  TestView.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/21.
//

#import "TestView.h"

@implementation TestView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.bannerViewStateChangeBlock) {
        self.bannerViewStateChangeBlock(self);
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
