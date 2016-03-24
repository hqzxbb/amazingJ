//
//  HBBRecommendTag.h
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/19.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBBRecommendTag : NSObject
/**
 *  图片
 */
@property (nonatomic,copy)NSString *image_list;

/**
 *  名字
 */
@property (nonatomic,copy)NSString *theme_name;

/**
 *  订阅数
 */
@property (nonatomic,assign) NSInteger sub_number;
@end
