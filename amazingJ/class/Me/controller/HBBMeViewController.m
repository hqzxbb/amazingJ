//
//  HBBMeViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBMeViewController.h"

@interface HBBMeViewController ()

@end

@implementation HBBMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置tabBarItem
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)], [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeBtnClick)]];
    
    self.view.backgroundColor = HBBGlobalRGB;

    
}

- (void)nightModeBtnClick{
    HBBLogFunc;
}

- (void)settingClick{
    HBBLogFunc;
}


@end
