//
//  UIView+HBBPropertyExtension.h
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HBBPropertyExtension)
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

/**
 *  判断一个控件是否正在显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

/**
 *  从xib中创建一个view
 */
+ (instancetype)viewFromNib;
@end
