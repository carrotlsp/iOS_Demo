#import "WSafeTimer.h"

@interface WSafeTimer()
@property(nonatomic,weak) NSTimer *timer;
@property(nonatomic,weak) id target;
@property(nonatomic,assign) SEL selector;
@end

@implementation WSafeTimer
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    WSafeTimer *safeTimer = [WSafeTimer new];
    
    safeTimer.target = aTarget;
    safeTimer.selector = aSelector;
    safeTimer.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:safeTimer selector:@selector(timerHandle) userInfo:userInfo repeats:yesOrNo];
    
    return safeTimer.timer;
}

-(void)timerHandle{
    if (self.target && [self.target respondsToSelector:self.selector]) {
        [self.target performSelector:self.selector];
    }else {
        [self.timer invalidate];
    }
}
@end
