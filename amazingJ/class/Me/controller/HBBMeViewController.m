//
//  HBBMeViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBMeViewController.h"
#import "HBBMeWebViewController.h"
#import "HBBSettingViewController.h"
#import "HBBMeFooterView.h"
#import "HBBMeTableViewCell.h"

@interface HBBMeViewController ()

@end

@implementation HBBMeViewController

static NSString *HBBMe = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];

    [self setupTableView];
    
}

/**
 *  初始化tableView
 */
- (void)setupTableView{
    // 设置背景色
    self.tableView.backgroundColor = HBBGlobalRGB;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HBBMeTableViewCell class] forCellReuseIdentifier:HBBMe];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = HBBTopicCellMargin;
    
    // 调整inset
    
    // 设置footerView
    self.tableView.tableFooterView = [[HBBMeFooterView alloc] init];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, self.tableView.tableFooterView.height + self.tabBarController.tabBar.frame.size.height, 0);

}

/**
 *  初始化导航栏
 */
- (void)setupNav{
    //设置导航栏标题
    self.navigationItem.title = @"我的";
    
    //设置tabBarItem
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)], [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeBtnClick)]];
    
}

- (void)nightModeBtnClick{
    HBBLogFunc;
}

- (void)settingClick{
    HBBLogFunc;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBBMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HBBMe];
 
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}


@end
