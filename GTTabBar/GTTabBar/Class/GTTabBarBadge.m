//
//  GTTabBarBadge.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "GTTabBarBadge.h"

@implementation GTTabBarBadge

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.itemBadgeType = GTTabBarItemBadgeTypeNone;
        [self setBackgroundImage:UIImage.new forState:UIControlStateNormal];
        [self setBackgroundImage:UIImage.new forState:UIControlStateHighlighted];
        [self setBackgroundImage:UIImage.new forState:UIControlStateSelected];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    [self updateView];
}

- (void)setBadgeTitleFont:(UIFont *)badgeTitleFont {
    _badgeTitleFont = badgeTitleFont;
    if (badgeTitleFont) {
        self.titleLabel.font = badgeTitleFont;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateView];
}

- (void)updateView {

    CGFloat view_x = self.superview.bounds.size.width * 0.5 + 12.0;
    CGFloat view_y = 7.0f;
    CGFloat view_w = 0.f;
    CGFloat view_h = 0.f;
    
    switch (self.itemBadgeType) {
        case GTTabBarItemBadgeTypeDote:
        {
            [self setTitle:@"" forState:UIControlStateNormal];
            view_w = 8.0f;
            view_h = view_w;
        }
            break;
        case GTTabBarItemBadgeTypeNume:
        {
            [self setTitle:self.badgeValue forState:UIControlStateNormal];
            CGSize titleSize = [self.badgeValue sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
            view_w = MIN(90, (titleSize.width + 10));
            view_h = 16.0f;
            view_y = 4;
            //有数字最少得是个正方形
            view_w = view_w < view_h ? view_h : view_w;
        }
            break;
        case GTTabBarItemBadgeTypeNone:
        default:
            break;
    }
    CGRect frame = CGRectMake(view_x, view_y, view_w, view_h);
    self.frame = frame;
    self.layer.cornerRadius = frame.size.height * 0.5;
    self.layer.masksToBounds = YES;
}

@end
