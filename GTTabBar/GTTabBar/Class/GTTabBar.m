//
//  GTTabBar.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "GTTabBar.h"

@implementation GTTabBar

- (NSMutableArray <GTTabBarItem *>*)tabBarItems {
    if (_tabBarItems == nil) {
        _tabBarItems = [[NSMutableArray alloc] init];
    }
    return _tabBarItems;
}

- (void)addTabBarItem:(UITabBarItem *)item {
    
    GTTabBarItem *tabBarItem = [[GTTabBarItem alloc] initWithItemImageRatio:5.f];
    
    tabBarItem.badgeTitleFont         = self.badgeTitleFont?:[UIFont systemFontOfSize:10.f];
    tabBarItem.itemTitleFont          = self.itemTitleFont?:[UIFont systemFontOfSize:10.f];
    tabBarItem.itemTitleColor         = self.itemTitleColor?:UIColor.darkGrayColor;
    tabBarItem.selectedItemTitleColor = self.itemselectedTitleColor?:UIColor.blackColor;;
    // 进行关联
    tabBarItem.tabBarItem = item;
    [self addSubview:tabBarItem];
    [self.tabBarItems addObject:tabBarItem];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabBarItemClick:)];
    [tabBarItem addGestureRecognizer:tapGR];
    
    if (self.tabBarItems.count == 1) {
        [self onClickTabBarItem:tabBarItem];
    }
}

- (void)tabBarItemClick:(UITapGestureRecognizer *)tap {
    GTTabBarItem *tabBarItem = (GTTabBarItem *)tap.view;
    [self onClickTabBarItem:tabBarItem];
}

- (void)onClickTabBarItem:(GTTabBarItem *)tabBarItem {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        [self.delegate tabBar:self didSelectedItemFrom:self.selectedItem.tag to:tabBarItem.tag];
    }
    
    self.selectedItem.selected = NO;
    self.selectedItem = tabBarItem;
    self.selectedItem.selected = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    int count = (int)self.tabBarItems.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / self.tabBarItems.count;
    CGFloat itemH = h;
    
    for (int index = 0; index < count; index++) {
        
        GTTabBarItem *tabBarItem = self.tabBarItems[index];
        tabBarItem.tag = index;
        CGFloat itemX = index * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
}

@end
