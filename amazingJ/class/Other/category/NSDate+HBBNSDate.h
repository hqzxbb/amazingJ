//
//  NSDate+HBBNSDate.h
//  amazingJ
//
//  Created by huangbins on 16/3/27.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HBBNSDate)
/**
 *  比较两个时间相差多久
 */
- (NSDateComponents *)delateFrom:(NSDate *)from;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYestorday;
@end
