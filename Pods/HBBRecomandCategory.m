//
//  HBBRecomandCategory.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/17.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBRecomandCategory.h"

@implementation HBBRecomandCategory
- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}
@end
