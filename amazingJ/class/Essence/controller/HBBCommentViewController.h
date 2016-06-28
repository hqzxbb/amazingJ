//
//  HBBCommentViewController.h
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBBEssenceTopic;
@interface HBBCommentViewController : UIViewController
/**
 *  帖子模型
 */
@property (nonatomic, strong) HBBEssenceTopic *topic;
@end
