//
//  HBBEssenceComment.h
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HBBEssenceUser;
@interface HBBEssenceComment : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger like_count;

@property (nonatomic, strong) HBBEssenceUser *user;
@end
