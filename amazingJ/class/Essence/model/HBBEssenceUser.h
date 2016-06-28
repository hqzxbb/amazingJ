//
//  HBBEssenceUser.h
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBBEssenceUser : NSObject
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *username;
/**
 *  用户性别
 */
@property (nonatomic, copy) NSString *sex;
/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *profile_image;
@end
