//
//  HBBMeTableViewCell.m
//  amazingJ
//
//  Created by huangbins on 6/28/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBMeTableViewCell.h"

@implementation HBBMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) {
        return;
    }
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.center = CGPointMake(HBBTopicCellMargin + self.imageView.width * 0.5, self.height * 0.5);
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + HBBTopicCellMargin;
    
}

@end
