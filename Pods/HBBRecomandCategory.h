//
//  HBBRecomandCategory.h
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/17.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBBRecomandCategory : NSObject

/**
 *  id
 */
@property (nonatomic,assign) NSInteger id;

/**
 *  总数
 */
@property (nonatomic,assign) NSInteger count;

/**
 *  类名
 */
@property (nonatomic,copy)NSString *name;

/**
 *  类别对应的用户数据
 */
@property (nonatomic,strong)NSMutableArray *users;

/**
 *  当前页
 */
@property (nonatomic,assign) NSInteger currentPage;

/**
 *  用户总数
 */
@property (nonatomic,assign) NSInteger total;
@end
