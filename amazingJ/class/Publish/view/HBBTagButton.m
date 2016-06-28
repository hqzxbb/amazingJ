//
//  HBBTagButton.m
//  amazingJ
//
//  Created by huangbins on 6/13/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBTagButton.h"

@implementation HBBTagButton

/**
 *  初始化tag
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = HBBTagBg;
        self.titleLabel.font = HBBTagFont;
    }
    return self;
}

/**
 *  设置tag大小
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * HBBTagMargin;
    self.height = HBBTagH;
}

/**
 *  设置button文字和图片按顺序横向展示
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.x = HBBTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + HBBTagMargin;
}



@end
