//
//  UITabBarItem+GTAnimatedImage.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "UITabBarItem+GTAnimatedImage.h"
#import <objc/runtime.h>

@implementation UITabBarItem (GTAnimatedImage)

- (void)setNormalAnimatedImage:(FLAnimatedImage *)normalAnimatedImage{
    objc_setAssociatedObject(self, @selector(normalAnimatedImage), normalAnimatedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (FLAnimatedImage *)normalAnimatedImage{
    return objc_getAssociatedObject(self, @selector(normalAnimatedImage));
}

- (void)setSelectedAnimatedImage:(FLAnimatedImage *)selectedAnimatedImage{
    objc_setAssociatedObject(self, @selector(selectedAnimatedImage), selectedAnimatedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (FLAnimatedImage *)selectedAnimatedImage{
    return objc_getAssociatedObject(self, @selector(selectedAnimatedImage));
}

- (void)setItemBadgeType:(GTTabBarItemBadgeType)itemBadgeType{
    objc_setAssociatedObject(self, @selector(itemBadgeType), @(itemBadgeType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (itemBadgeType == GTTabBarItemBadgeTypeDote) {
        self.badgeValue = @"0";
    }else if (itemBadgeType == GTTabBarItemBadgeTypeNone){
        self.badgeValue = nil;
    }
}
- (GTTabBarItemBadgeType)itemBadgeType{
    return [objc_getAssociatedObject(self, @selector(itemBadgeType)) integerValue];
}

@end
