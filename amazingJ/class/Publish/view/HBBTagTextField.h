//
//  HBBTagTextField.h
//  amazingJ
//
//  Created by huangbins on 6/13/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBBTagTextField : UITextField
/**
 *  按删除键之后回调这个block
 */
@property (nonatomic, copy) void (^deleteBlock)();
@end
