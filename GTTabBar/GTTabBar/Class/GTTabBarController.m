//
//  GTTabBarController.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "GTTabBarController.h"

@interface GTTabBarController ()

@end

@implementation GTTabBarController

- (void)loadView {
    [super loadView];
    
    GTTabBar *tabBar = [[GTTabBar alloc] init];
    tabBar.frame     = self.tabBar.bounds;
    tabBar.delegate  = self;
    self.gtTabBar = tabBar;
    [self.tabBar addSubview:tabBar];
    
    [self.tabBar setTranslucent:NO];
    [self.tabBar setBackgroundImage:UIImage.new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideOriginControls)
                                                 name:kGTNotificationTabBarItemChanged object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideOriginControls];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self hideOriginControls];
}

- (void)hideOriginControls {
    self.gtTabBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        if ([obj isKindOfClass:[UIControl class]]) {
            [obj setHidden:YES];
        }
    }];
}

// 1.赋值nav的方式只能选[setViewControllers:]
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    
    [self.gtTabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.gtTabBar.tabBarItems = [NSMutableArray array];
    
    for (UINavigationController *nav in viewControllers) {
        
        // 2.为了启动KVO,赋值和关联的tabBarItem需要相同
        NSString *title = nav.tabBarItem.title;
        nav.tabBarItem.title = title;
        [self.gtTabBar addTabBarItem:nav.tabBarItem];
    }
    
    [super setViewControllers:viewControllers];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    self.gtTabBar.selectedItem.selected = NO;
    self.gtTabBar.selectedItem = self.gtTabBar.tabBarItems[selectedIndex];
    self.gtTabBar.selectedItem.selected = YES;
}

#pragma mark - XXTabBarDelegate Method

- (void)tabBar:(GTTabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to {
    
    self.selectedIndex = to;
}

@end
