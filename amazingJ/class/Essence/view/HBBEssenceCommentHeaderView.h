//
//  HBBEssenceCommentHeaderView.h
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBBEssenceCommentHeaderView : UITableViewHeaderFooterView
/**
 *  文字数据
 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
