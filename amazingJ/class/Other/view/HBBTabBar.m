//
//  HBBTabBar.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBTabBar.h"

@interface HBBTabBar()
@property (nonatomic,weak) UIButton *publishButton;

@end

@implementation HBBTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        self.publishButton.size = publishButton.currentBackgroundImage.size;
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置发布按钮的位置
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width * 0.2;
    CGFloat buttonH = self.height;
    
    NSInteger index = 0;
    for (UIView *btn in self.subviews) {
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        CGFloat buttonX = buttonW * (index > 1 ? (index+1):index);
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        index++;
    }
}

@end
