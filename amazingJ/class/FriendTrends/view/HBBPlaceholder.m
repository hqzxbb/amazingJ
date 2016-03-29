//
//  HBBPlaceholder.m
//  amazingJ
//
//  Created by huangbins on 16/3/23.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBPlaceholder.h"
#import <objc/runtime.h>

@implementation HBBPlaceholder


- (void)awakeFromNib{
//    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor redColor];
    
    //设置placeholder的颜色
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
}

- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end
