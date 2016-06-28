//
//  HBBPlaceHolderTextView.h
//  amazingJ
//
//  Created by huangbins on 5/19/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBBPlaceHolderTextView : UITextView

/**
 *  占位文字
 */
@property (nonatomic, copy) NSString *placeholderText;
/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor* placeholderColor;
@end
