//
//  GTTabBarBadge.h
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITabBarItem+GTAnimatedImage.h"

@interface GTTabBarBadge : UIButton

@property (nonatomic, assign) GTTabBarItemBadgeType itemBadgeType;

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, strong) UIFont *badgeTitleFont;

@end

