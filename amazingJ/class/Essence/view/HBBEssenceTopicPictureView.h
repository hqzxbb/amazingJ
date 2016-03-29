//
//  HBBEssenceTopicPictureView.h
//  amazingJ
//
//  Created by huangbins on 3/28/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBBEssenceTopic;

@interface HBBEssenceTopicPictureView : UIView
+ (instancetype)pictureView;
@property (nonatomic, strong) HBBEssenceTopic *topic;
@end
