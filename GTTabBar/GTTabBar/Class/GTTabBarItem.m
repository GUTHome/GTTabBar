//
//  GTTabBarItem.m
//  GTTabBar
//
//  Created by tanxl on 2019/12/29.
//  Copyright © 2019 tanxl. All rights reserved.
//

#import "GTTabBarItem.h"
#import "Masonry.h"
#import "GTTabBarBadge.h"
#import "UITabBarItem+GTAnimatedImage.h"

NSString *const kGTNotificationTabBarItemChanged = @"kGTNotificationTabBarItemChanged";

@interface GTTabBarItem ()

@property (nonatomic, strong) GTTabBarBadge *tabBarBadge;

@end

@implementation GTTabBarItem

- (void)dealloc {
    /// 需要同步什么信息就监听并实现对应的逻辑
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio {
    self = [super init];
    if (self) {
        
        UILabel *titleLabel      = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self).offset(-5);
        }];
        
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        itemImageRatio = itemImageRatio <= 0  ? 5 : itemImageRatio;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeZero);
            make.bottom.mas_equalTo(titleLabel.mas_top).offset(-itemImageRatio);
        }];
        
        GTTabBarBadge *tabBarBadge = [[GTTabBarBadge alloc] initWithFrame:CGRectZero];
        [self addSubview:tabBarBadge];
        
        _imageView   = imageView;
        _titleLabel  = titleLabel;
        _tabBarBadge = tabBarBadge;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.tabBarBadge setNeedsLayout];
}

#pragma mark -

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    [self updateViewContent];
}

- (void)setBadgeTitleFont:(UIFont *)badgeTitleFont {
    _badgeTitleFont = badgeTitleFont;
    if (badgeTitleFont) {
        self.tabBarBadge.badgeTitleFont = badgeTitleFont;
    }
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont{
    _itemTitleFont = itemTitleFont;
    if (itemTitleFont) {
        self.titleLabel.font = itemTitleFont;
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor{
    _itemTitleColor = itemTitleColor;
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor{
    _selectedItemTitleColor = selectedItemTitleColor;
}

#pragma mark -

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    
    _tabBarItem = tabBarItem;
    
    [tabBarItem addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [tabBarItem addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kGTNotificationTabBarItemChanged object:nil];
    
    [self updateViewContent];
}

- (void)updateViewContent {
    // 文字
    NSDictionary *textAttributes = self.selected ? [[UITabBarItem appearance] titleTextAttributesForState:(UIControlStateSelected)] : [[UITabBarItem appearance] titleTextAttributesForState:(UIControlStateNormal)];
    if (textAttributes.count) {
        NSString *name = self.tabBarItem.title;
        self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:name attributes:textAttributes];
    }else{
        self.titleLabel.text = self.tabBarItem.title;
        self.titleLabel.textColor = self.isSelected ? self.selectedItemTitleColor : self.itemTitleColor;
    }
    
    // 图标
    FLAnimatedImage *animatedImage = self.selected ? self.tabBarItem.selectedAnimatedImage : self.tabBarItem.normalAnimatedImage;
    UIImage *image = self.selected ? self.tabBarItem.selectedImage : self.tabBarItem.image;
    if (image == nil) {
        image = self.selected ? [self.tabBarItem valueForKey:@"_selectedTemplateImage"] : [self.tabBarItem valueForKey:@"_templateImage"];
    }
    
    if (self.isSelected) {
        if (animatedImage) {
            self.imageView.animatedImage = animatedImage;
            self.imageView.image = nil;
        }else{
            self.imageView.animatedImage = nil;
            self.imageView.image = image;
        }
    } else {
        if (animatedImage) {
            self.imageView.animatedImage = animatedImage;
            self.imageView.image = nil;
        }else{
            self.imageView.animatedImage = nil;
            self.imageView.image = image;
        }
    }
    CGSize imageSize = [FLAnimatedImage sizeForImage:animatedImage ?: image];
    CGFloat sizeWidth = animatedImage ? imageSize.width/2.0 : imageSize.width;
    if (sizeWidth > 25) {
        imageSize = CGSizeMake(40, 40);
    }else{
        imageSize = CGSizeMake(25, 25);
    }
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imageSize);
    }];
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.05 animations:^{
        [self layoutIfNeeded];
    }];
    
    // badge
    self.tabBarBadge.itemBadgeType = self.tabBarItem.itemBadgeType;
    if (self.tabBarBadge.itemBadgeType == GTTabBarItemBadgeTypeNume) {
        self.tabBarBadge.badgeValue = self.tabBarItem.badgeValue;
    }else if (self.tabBarBadge.itemBadgeType == GTTabBarItemBadgeTypeDote){
        self.tabBarBadge.badgeValue = @"";
    }else if (self.tabBarBadge.itemBadgeType == GTTabBarItemBadgeTypeNone){
        self.tabBarBadge.badgeValue = @"";
    }
}

@end

