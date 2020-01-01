//
//  DemoTabBarController.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "DemoTabBarController.h"
#import "DemoViewController.h"
#import "UITabBarItem+GTAnimatedImage.h"

@interface DemoTabBarController ()

@end

@implementation DemoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self test];
}

- (void)test{
    
    DemoViewController *vc1 = [[DemoViewController alloc] init];
    UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    navC1.tabBarItem.image = [UIImage imageNamed:@"1_1"];
    navC1.tabBarItem.selectedImage = [UIImage imageNamed:@"1_2"];
    navC1.tabBarItem.title = @"test1";
    navC1.tabBarItem.itemBadgeType = GTTabBarItemBadgeTypeDote;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        navC1.tabBarItem.itemBadgeType = GTTabBarItemBadgeTypeNume;
        navC1.tabBarItem.badgeValue = @"9";
    });
    
    DemoViewController *vc2 = [[DemoViewController alloc] init];
    UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    navC2.tabBarItem.image = [UIImage imageNamed:@"2_1"];
    navC2.tabBarItem.selectedImage = [UIImage imageNamed:@"2_2"];
    navC2.tabBarItem.title = @"test2";
    navC2.tabBarItem.itemBadgeType = GTTabBarItemBadgeTypeNume;
    navC2.tabBarItem.badgeValue = @"24";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        navC2.tabBarItem.itemBadgeType = GTTabBarItemBadgeTypeDote;
    });
    
    DemoViewController *vc3 = [[DemoViewController alloc] init];
    UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    navC3.tabBarItem.selectedImage = [UIImage imageNamed:@"2_1"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_1" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    FLAnimatedImage *imageAnimation = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
    navC3.tabBarItem.normalAnimatedImage = imageAnimation;
    navC3.tabBarItem.title = @"test3";
    navC3.tabBarItem.badgeValue = @"9";
    navC3.tabBarItem.itemBadgeType = GTTabBarItemBadgeTypeNume;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        navC3.tabBarItem.itemBadgeType = GTTabBarItemBadgeTypeNone;
    });
    
    DemoViewController *vc4 = [[DemoViewController alloc] init];
    UINavigationController *navC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"test_1" ofType:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfFile:path1];
    FLAnimatedImage *imageAnimation1 = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data1];
    navC4.tabBarItem.normalAnimatedImage = imageAnimation1;
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"test_2" ofType:@"gif"];
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    FLAnimatedImage *imageAnimation2 = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data2];
    navC4.tabBarItem.selectedAnimatedImage = imageAnimation2;
    navC4.tabBarItem.title = @"test4";
    
    /**************************************** Key Code ****************************************/
    // 必须通过setViewControllers:方式赋值
    self.viewControllers = @[navC1, navC2, navC3, navC4];
}

@end

// tabitem 会变化的s问题在h于  赋值和关联的地方不是同一个的 set
//- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
//
//    [self.gtTabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    self.gtTabBar.tabBarItems = [NSMutableArray array];
//
//    for (UINavigationController *nav in viewControllers) {
//
//        // 为了启动KVO
            /////????? 这里用的nav.tabBarItem
//        NSString *title = nav.tabBarItem.title;
//        nav.tabBarItem.title = title;
//
//        [self.gtTabBar addTabBarItem:nav.tabBarItem];
//        NSLog(@"%@", viewControllers[2].tabBarItem);
//    }
//
//    [super setViewControllers:viewControllers];
//}
