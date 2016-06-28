//
//  HBBTabBar.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBTabBar.h"
#import "HBBPublicViewController.h"

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
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        self.publishButton.size = publishButton.currentBackgroundImage.size;
    }
    return self;
}

- (void)publishClick{
    HBBPublicViewController *publishVC = [[HBBPublicViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:YES completion:nil];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //按钮是否添加过监听器标识
    static BOOL isAddObserver = NO;
    
    //设置发布按钮的位置
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width * 0.2;
    CGFloat buttonH = self.height;
    
    NSInteger index = 0;
    for (UIControl *btn in self.subviews) {
        
        if (![btn isKindOfClass:[UIControl class]] || btn == self.publishButton) {
            continue;
        }
        
        //计算按钮的x值
        CGFloat buttonX = buttonW * (index > 1 ? (index+1):index);
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //增加索引
        index++;
        
        //添加监听器
        if (isAddObserver == NO) {
            //监听按钮点击
            [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
        isAddObserver = YES;
    }
}


- (void)buttonClick{
    //发出一个通知
    [HBBNotificationCenter postNotificationName:HBBTabBarDidSelectNotifacation object:nil userInfo:nil];
}
@end
