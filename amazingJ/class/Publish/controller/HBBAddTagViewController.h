//
//  HBBAddTagViewController.h
//  amazingJ
//
//  Created by huangbins on 6/11/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBBAddTagViewController : UIViewController
/**
 *  获取tags的block
 */
@property (nonatomic, copy) void(^tagsBlock)(NSArray *tags);

/**
 *  所有的标签
 */
@property (nonatomic, strong) NSArray *tags;
@end
