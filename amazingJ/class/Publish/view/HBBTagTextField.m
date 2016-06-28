//
//  HBBTagTextField.m
//  amazingJ
//
//  Created by huangbins on 6/13/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBTagTextField.h"

@implementation HBBTagTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签用逗号或换行隔开";
        //设置了占位文字内容以后，才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = HBBTagH;
    }
    return self;
}

/**
 *  监听键盘的输入
 */
- (void)deleteBackward{
    !self.deleteBlock ?: self.deleteBlock();
    
    [super deleteBackward];
}


@end
