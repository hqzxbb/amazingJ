//
//  HBBEssenceViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBEssenceViewController.h"
#import "HBBRecommendTagsViewController.h"

@interface HBBEssenceViewController ()

@end

@implementation HBBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏的内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(essenceClick)];
    
    self.view.backgroundColor = HBBGlobalRGB;
}

- (void)essenceClick{
    
    HBBRecommendTagsViewController *recommandTagsVC = [[HBBRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:recommandTagsVC animated:YES];
}
@end
