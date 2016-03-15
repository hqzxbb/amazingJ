//
//  HBBFriendTrendsViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBFriendTrendsViewController.h"

@interface HBBFriendTrendsViewController ()

@end

@implementation HBBFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置tabBarItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
    
    self.view.backgroundColor = HBBGlobalRGB;
    
}

- (void)friendsRecommentClick{
    HBBLogFunc;
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
