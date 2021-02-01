#import "WLikeAnimationView.h"
#import "WSafeTimer.h"

@interface WLikeAnimationView()
@property(nonatomic,strong) NSTimer *timer;
@end

@implementation WLikeAnimationView

+(instancetype)initWithStartingPoint:(CGPoint)point{
    
    CGFloat w = 80;
    CGFloat x = point.x - w*0.5;
    CGFloat h = 220;
    CGFloat y = point.y - h;
    WLikeAnimationView *view = [[WLikeAnimationView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    // 添加计时器, 每隔一段时间自动冒泡泡
//    view.timer = [WSafeTimer scheduledTimerWithTimeInterval:6 target:view selector:@selector(changeTimer) userInfo:nil repeats:YES];
    
    return view;
}

#pragma mark - 计时器
-(void)changeTimer {
    [self startAnimation];
}

#pragma mark - 执行冒泡动画
-(void)startAnimation {
    // 每次点击随机弹出3~5次
    
    [self startAnimation_once];
    return;
    
//    int count = 3 + arc4random_uniform(3);
//    for (int i=0; i<count; i++) {
//        float delayInSeconds = 0.4 * i;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self startAnimation_once];
//        });
//    }
}

#pragma mark - 执行一次冒泡动画
-(void)startAnimation_once {
    CGFloat imgWH = 20;
    CGFloat x_center = (self.bounds.size.width-imgWH) * 0.5;
    CGFloat x_max = self.bounds.size.width - imgWH;
    // 起始位置
    CGFloat x_0 = x_center;
    CGFloat y_0 = self.bounds.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x_0, y_0, imgWH, imgWH)];
    [self addSubview:imageView];
    imageView.backgroundColor = [UIColor clearColor];
    
    // 随机获取图片 gift01
    NSString *imageName = [NSString stringWithFormat:@"gift%02d",arc4random_uniform(6)+1];
    imageView.image = [UIImage imageNamed:imageName];
    
    // 生成x的随机偏移量, 并创建动画路径的经过的位置
    CGFloat xOffset = self.bounds.size.width*0.4*(arc4random_uniform(10)/10.0);
    // 生成y的随机偏移量, 并创建动画路径的经过的位置
    CGFloat yOffset = self.bounds.size.height*0.2*(arc4random_uniform(10)/10.0);
    CGFloat y_1 = self.bounds.size.height - self.bounds.size.height/10.0*2.0;
    CGFloat y_2 = self.bounds.size.height - self.bounds.size.height/10.0*4.0 - yOffset;
    CGFloat y_3 = self.bounds.size.height - self.bounds.size.height/10.0*6.0 - yOffset;
    CGFloat y_4 = self.bounds.size.height - self.bounds.size.height/10.0*10.0 - yOffset;
    // 生产路径的关键点
    CGPoint p0 = CGPointMake(x_0, y_0);
    CGPoint p1 = CGPointMake(xOffset, y_1);
    CGPoint p2 = CGPointMake(x_max-xOffset, y_2);
    CGPoint p3 = CGPointMake(xOffset, y_3);
    CGPoint p4 = CGPointMake(x_max-xOffset, y_4);
    
    // 生成随机执行时间 3~4秒
    CGFloat duration = 3 + arc4random_uniform(1000)/1000.0;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0]; // 起点
    [bezierPath addLineToPoint:p1]; // 经过点
    [bezierPath addLineToPoint:p2]; // 经过点
    [bezierPath addLineToPoint:p3]; // 经过点
    [bezierPath addLineToPoint:p4]; // 终点
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = bezierPath.CGPath;
    // 动画时间间隔
    animation.duration = duration;
    // 重复次数为最大值
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    // 控制动画的显示节奏 先慢后快再慢
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    [animation setTimingFunction:timingFunction];
    // 为imageView添加路径动画
    [imageView.layer addAnimation:animation forKey:nil];
    // 添加渐隐动画, 执行完成后移除imageView
    [UIView animateWithDuration:duration+0.25 animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

#pragma mark - other
-(void)clearTimer{
    if(self.timer != nil){
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)dealloc{
    NSLog(@"WLikeAnimationView view dealloc");
    [self clearTimer];
}

@end
