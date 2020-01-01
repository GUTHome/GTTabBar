//
//  UITabBarItem+GTAnimatedImage.h
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"


typedef NS_ENUM(NSInteger, GTTabBarItemBadgeType){
    GTTabBarItemBadgeTypeNone   = 0, //无
    GTTabBarItemBadgeTypeDote   = 1, //红点
    GTTabBarItemBadgeTypeNume   = 2, //数字
};

@interface UITabBarItem (GTAnimatedImage)

@property (nonatomic, assign) GTTabBarItemBadgeType itemBadgeType;

/**
非选中与选中状态下的gif数据,注意赋值给此属性时必须清理掉原生状态下对应的值
写法例如：

UITabBarItem.normalAnimatedImage = [[FLAnimatedImage alloc] initxxxx];
UITabBarItem.image = nil;

UITabBarItem.selectedAnimatedImage = [[FLAnimatedImage alloc] initxxxx];
UITabBarItem.selectedImage = nil;
*/
@property (nonatomic ,strong) FLAnimatedImage *normalAnimatedImage;
@property (nonatomic ,strong) FLAnimatedImage *selectedAnimatedImage;

@end

