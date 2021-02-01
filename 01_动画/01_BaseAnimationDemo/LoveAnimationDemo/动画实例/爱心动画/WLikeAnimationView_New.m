#import "WLikeAnimationView_New.h"

@interface WLikeAnimationView_New()<CAAnimationDelegate>

@property (nonatomic, strong) NSMutableSet<UIImageView *> *loveSet;

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;
@end

@implementation WLikeAnimationView_New
#pragma mark - 执行一次冒泡动画
-(void)startAnimationOnce {
    
    UIImageView *imageView = [self dequeueImageView];
    [self addSubview:imageView];
    
    CGFloat duration = 2.25;
    NSMutableArray *animations = [NSMutableArray array];
    
    {   // 路径动画
        // 随机生成正负两个方向
        BOOL isNagative = arc4random_uniform(2) % 2;
        // 生成随机生成宽度的比例 0.7 ~ 1.5
        CGFloat widthPercentage =  (arc4random_uniform(800) + 700) / 1000.0;
        // 生成随机生成顶点 X 轴的的比例 0 ~ 1.0
        CGFloat endPointXPercentage =  arc4random_uniform(10000) / 10000.0;
//        NSLog(@" %i, %f, %f",isNagative, widthPercentage, endPointXPercentage);
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(self.viewWidth / 2.0, self.viewHeight)];
        if (isNagative) {
            [bezierPath addCurveToPoint:CGPointMake(self.viewWidth * endPointXPercentage, 0) controlPoint1:CGPointMake(self.viewWidth / 2 + self.viewWidth * widthPercentage, self.viewHeight / 3 * 2) controlPoint2:CGPointMake(self.viewWidth / 2 - self.viewWidth * widthPercentage, self.viewHeight / 3)];
        } else {
            [bezierPath addCurveToPoint:CGPointMake(self.viewWidth * endPointXPercentage, 0) controlPoint1:CGPointMake(self.viewWidth / 2 - self.viewWidth * widthPercentage , self.viewHeight / 3  * 2) controlPoint2:CGPointMake(self.viewWidth / 2 + self.viewWidth * widthPercentage , self.viewHeight / 3)];
        }
            
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = bezierPath.CGPath;
        // 动画时间间隔
        animation.duration = duration;
        // 重复次数为最大值
        animation.repeatCount = 1;
        // 控制动画的显示节奏 先慢后快再慢
        CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [animation setTimingFunction:timingFunction];
        [animations addObject:animation];
    }
    {   // 缩放动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.keyTimes = @[@(0), @(0.5), @(1.0)];
        animation.values = @[@(0.2), @(0.5), @(1.0)];
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = 0.15;
        [animations addObject:animation];
    }
    {   // 淡出隐藏动画
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        animation.keyTimes = @[@(0), @(1.0)];
        animation.values = @[@(1.0), @(0)];
        animation.duration = 1.2;
        animation.beginTime = duration - 1.2;
        [animations addObject:animation];
    }
    
    CAAnimationGroup *group = [CAAnimationGroup new];
    group.animations = animations;
    group.duration = duration;
    // 为imageView添加动画组
    [imageView.layer addAnimation:group forKey:@"animationGroup"];
    
    // 动画结束，把ImageView放回池子里
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loveSet addObject:imageView];
        [imageView.layer removeAllAnimations];
        imageView.transform = CGAffineTransformIdentity;
        [imageView removeFromSuperview];
        
    });
}

#pragma mark - Private Methods
/// 从缓存池中获取ImageView
- (UIImageView *)dequeueImageView {
    NSLog(@"%ld", self.loveSet.count);
    UIImageView *imageView = [self.loveSet anyObject];
    if (imageView != nil) {
        [self.loveSet removeObject:imageView];
    } else {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        imageView.backgroundColor = [UIColor clearColor];
    }
    imageView.frame = CGRectMake(self.viewWidth / 2.0, self.viewHeight, 32, 32);
    imageView.transform = CGAffineTransformMakeScale(0,0);
    // 随机获取图片 gift01
    NSString *imageName = [NSString stringWithFormat:@"gift%02d",arc4random_uniform(6)+1];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}


-(void)dealloc{
    NSLog(@"WLikeAnimationView_New view dealloc");
}


#pragma mark - Getters

- (NSMutableSet<UIImageView *> *)loveSet {
    if (!_loveSet) {
        _loveSet = [NSMutableSet set];
    }
    return _loveSet;
}

- (CGFloat)viewWidth {
    if (!_viewWidth) {
        _viewWidth = self.bounds.size.width;
    }
    return _viewWidth;
}

- (CGFloat)viewHeight {
    if (!_viewHeight) {
        _viewHeight = self.bounds.size.height;
    }
    return _viewHeight;
}

@end
