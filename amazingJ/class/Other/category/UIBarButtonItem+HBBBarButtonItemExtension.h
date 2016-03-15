//
//  UIBarButtonItem+HBBBarButtonItemExtension.h
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HBBBarButtonItemExtension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
