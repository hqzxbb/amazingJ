//
//  UIBarButtonItem+HBBBarButtonItemExtension.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "UIBarButtonItem+HBBBarButtonItemExtension.h"

@implementation UIBarButtonItem (HBBBarButtonItemExtension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action{
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tagBtn setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    tagBtn.size = tagBtn.currentBackgroundImage.size;
    [tagBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:tagBtn];
}
@end
