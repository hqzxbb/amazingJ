//
//  HBBRecommendUser.h
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/17.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBBRecommendUser : NSObject
/**
 *  头像
 */
@property (nonatomic,copy)NSString *header;
/**
 *  粉丝数
 */
@property (nonatomic,assign) NSInteger fans_count;
/**
 *  昵称
 */
@property (nonatomic,copy)NSString *screen_name;
@end
