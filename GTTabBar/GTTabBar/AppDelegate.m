//
//  AppDelegate.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    DemoTabBarController *tab = [DemoTabBarController new];
    self.window.rootViewController = tab;
    
    return YES;
}

@end
