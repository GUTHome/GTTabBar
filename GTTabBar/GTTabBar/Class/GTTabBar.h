//
//  GTTabBar.h
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTabBarItem.h"
#import "UITabBarItem+GTAnimatedImage.h"

@class GTTabBar;
@protocol GTTabBarDelegate <NSObject>

- (void)tabBar:(GTTabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface GTTabBar : UIView

- (void)addTabBarItem:(UITabBarItem *)item;

@property (nonatomic, strong) NSMutableArray <GTTabBarItem *>*tabBarItems;

@property (nonatomic, strong) GTTabBarItem *selectedItem;

@property (nonatomic, weak) id<GTTabBarDelegate> delegate;

// 以下是对GTTabBarItem属性的暴露
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *itemselectedTitleColor;
@property (nonatomic, strong) UIFont *itemTitleFont;
@property (nonatomic, strong) UIFont *badgeTitleFont;

@end



