//
//  HBBFriendTrendsViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBFriendTrendsViewController.h"
#import "HBBRecomandViewController.h"

@interface HBBFriendTrendsViewController ()

@end

@implementation HBBFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置tabBarItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
    
    //设置背景
    self.view.backgroundColor = HBBGlobalRGB;
    
}

- (void)friendsRecommentClick{
    HBBRecomandViewController *vc = [[HBBRecomandViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
