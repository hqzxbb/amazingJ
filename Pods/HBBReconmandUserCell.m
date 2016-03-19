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
    
    self.fansCountLabel.text = [NSString stringWithFormat:@"%d",(int)user.fans_count];
    
}

@end
