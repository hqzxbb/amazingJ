//
//  HBBEssenceCommentHeaderView.m
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBEssenceCommentHeaderView.h"

@interface HBBEssenceCommentHeaderView()
/**
 *  文字标签
 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation HBBEssenceCommentHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"header";
    HBBEssenceCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[HBBEssenceCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier: reuseIdentifier]) {
        self.contentView.backgroundColor = HBBGlobalRGB;
        
        //创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = HBBRGBColor(67, 67, 67);
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
        
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    
    self.label.text = title;
}

@end
