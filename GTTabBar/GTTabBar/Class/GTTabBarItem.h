//
//  GTTabBarItem.h
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView+WebCache.h"

extern NSString *const kGTNotificationTabBarItemChanged;

@interface GTTabBarItem : UIView

@property (nonatomic, strong) UITabBarItem *tabBarItem;             //关联的原生TabBarItem

@property (nonatomic, assign, getter=isSelected) BOOL selected;     //选择状态

@property (nonatomic, strong) FLAnimatedImageView *imageView;       //图标

@property (nonatomic, strong) UILabel *titleLabel;                  //文字

@property (nonatomic, strong) UIColor *itemTitleColor;              //文字默认颜色

@property (nonatomic, strong) UIColor *selectedItemTitleColor;      //文字选中颜色

@property (nonatomic, strong) UIFont *itemTitleFont;                //文字字体

@property (nonatomic, strong) UIFont *badgeTitleFont;               //Badge字体

/**
 *  初始化，默认文字和图标间距参数，接近官方数据ratio为5pt
 */
- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio;

@end

