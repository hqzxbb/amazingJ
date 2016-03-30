//
//  HBBEssenceTopicVoiceView.h
//  amazingJ
//
//  Created by huangbins on 3/30/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBBEssenceTopic;
@interface HBBEssenceTopicVoiceView : UIView

+ (instancetype)voiceView;
@property (nonatomic, strong) HBBEssenceTopic *topic;
@end
