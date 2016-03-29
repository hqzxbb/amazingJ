//
//  NSDate+HBBNSDate.m
//  amazingJ
//
//  Created by huangbins on 16/3/27.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "NSDate+HBBNSDate.h"

@implementation NSDate (HBBNSDate)
/**
 *  比较from和self的时间差值
 */
- (NSDateComponents *)delateFrom:(NSDate *)from{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear{
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}
/**
    *  是否为今天
*/
- (BOOL)isToday{
//    //日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    //比较时间
//    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
//    NSDateComponents *nowComponets = [calendar components:unit fromDate:[NSDate date]];
//    NSDateComponents *selfComponets = [calendar components:unit fromDate:self];
//    
//    return selfComponets.year == nowComponets.year && selfComponets.month == nowComponets.month && selfComponets.day == nowComponets.day;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}
/**
 *  是否为昨天
 */
- (BOOL)isYestorday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return  cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
@end
