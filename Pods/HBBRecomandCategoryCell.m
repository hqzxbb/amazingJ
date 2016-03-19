//
//  HBBRecomandCategoryCell.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/17.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBRecomandCategoryCell.h"
#import "HBBRecomandCategory.h"

@interface HBBRecomandCategoryCell()
/**
 *  选中时显示的指示器
 */
@property (weak, nonatomic) IBOutlet UIView *selectedleftView;

@end

@implementation HBBRecomandCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = HBBRGBColor(244, 244, 244);
    
    self.selectedleftView.backgroundColor = HBBRGBColor(219, 21, 26);
    
//    self.textLabel.textColor = HBBRGBColor(78, 78, 78);
//    
//    self.textLabel.highlightedTextColor = HBBRGBColor(219, 21, 26);
//    
//    UIView *bg = [[UIView alloc] init];
//    
//    bg.backgroundColor = [UIColor clearColor];
//    
//    self.selectedBackgroundView = bg;
}

- (void)setCategory:(HBBRecomandCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //调整textLable的大小
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    
    self.selectedleftView.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedleftView.backgroundColor : HBBRGBColor(78, 78, 78);
    
}

@end
