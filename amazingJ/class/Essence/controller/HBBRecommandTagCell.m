//
//  HBBRecommandTagCell.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/20.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBRecommandTagCell.h"
#import "HBBRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface HBBRecommandTagCell()
@property (weak, nonatomic) IBOutlet UILabel *themeNameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLable;

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;

@end

@implementation HBBRecommandTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRecommendTag:(HBBRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLable.text = recommendTag .theme_name;
    
    NSString *subNumber = nil;
    
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommendTag.sub_number];
    } else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",(recommendTag.sub_number/10000.0)];
    }
    
    self.subNumberLable.text = subNumber;
}

/**
 *  设置frame
 */
- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    
    frame.size.height -= 1;
    
    frame.size.width -= 2 * frame.origin.x;
    
    [super setFrame:frame];
}
@end
