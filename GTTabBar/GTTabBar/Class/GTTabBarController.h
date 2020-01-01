//
//  GTTabBarController.h
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTTabBar.h"

@interface GTTabBarController : UITabBarController
<GTTabBarDelegate>

@property (nonatomic, strong) GTTabBar *gtTabBar;

- (void)hideOriginControls;

@end
