//
//  AppDelegate.m
//  LoveAnimationDemo
//
//  Created by 林思沛 on 2021/1/12.
//

#import "AppDelegate.h"
#import "SingleAnimationViewController.h"
#import "MultiAnimationViewController.h"
#import "GroupAnimationViewController.h"
#import "LikeViewController.h"
#import "BezierViewController.h"
#import "BarrageViewController.h"
#import "LiveBannerViewController.h"
#import "ViewBlockAnimationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewBlockAnimationViewController alloc] init];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskLandscapeRight;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}



@end
