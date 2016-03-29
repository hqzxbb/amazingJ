//
//  HBBRecommendTagsViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/19.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBRecommendTagsViewController.h"
#import "HBBRecommandTagCell.h"
#import "HBBRecommendTag.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface HBBRecommendTagsViewController ()
/**
 *  标签数组
 */
@property (nonatomic,strong)NSArray *tags;


@end

static NSString *const HBBTagsID = @"tag";

@implementation HBBRecommendTagsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化tableView
    [self setupTableView];
    
    //发送网络请求
    [self loadTags];
    
}

/**
 *  发送网络请求
 */
- (void)loadTags{
    //添加蒙板
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.tags = [HBBRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        
        //请求成功，dismiss蒙板
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败！"];
    }];

}

/**
 *  初始化tableView
 */
- (void)setupTableView{
    self.title = @"推荐标签";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBBRecommandTagCell class]) bundle:nil] forCellReuseIdentifier:HBBTagsID];
    
    self.tableView.rowHeight = 50;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = HBBGlobalRGB;

}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBBRecommandTagCell *cell = [tableView dequeueReusableCellWithIdentifier:HBBTagsID];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}




@end
