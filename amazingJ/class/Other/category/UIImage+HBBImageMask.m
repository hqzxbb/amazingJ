//
//  UIImage+HBBImageMask.m
//  amazingJ
//
//  Created by huangbins on 5/11/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "UIImage+HBBImageMask.h"

@implementation UIImage (HBBImageMask)
- (UIImage *)circleImage{
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //在上下文中添加一个裁剪形状
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //将图片画上去
    [self drawInRect:rect];
    
    //从当前图形上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
