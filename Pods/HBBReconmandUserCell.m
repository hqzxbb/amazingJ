//
//  HBBReconmandUserCell.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/17.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBReconmandUserCell.h"
#include "HBBRecommendUser.h"
#include <UIImageView+WebCache.h>

@interface HBBReconmandUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation HBBReconmandUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(HBBRecommendUser *)user{
    _user = user;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *subNumber = nil;
    
    if (user.fans_count < 10000) {
        subNumber = [NSString stringWithFormat:@"%d人关注",(int)user.fans_count];
    } else{
        subNumber = [NSString stringWithFormat:@"%.1f万人关注",(user.fans_count/10000.0)];
    }
    
    self.fansCountLabel.text = subNumber;
    
}

@end
