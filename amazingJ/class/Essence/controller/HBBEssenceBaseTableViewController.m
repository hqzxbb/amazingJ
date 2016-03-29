//
//  HBBEssenceBaseTableViewController.m
//  amazingJ
//
//  Created by huangbins on 16/3/25.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBEssenceBaseTableViewController.h"
#import <AFNetworking.h>
#import "HBBEssenceTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "HBBEssenceTopicCell.h"

@interface HBBEssenceBaseTableViewController ()
/**
 *  帖子数据
 */
@property (nonatomic, strong) NSMutableArray *topics;
/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger page;
/**
 *  当加载下一页数据时，需要这个参数
 */
@property (nonatomic, copy) NSString *maxtime;
/**
 *  请求参数
 */
@property (nonatomic, strong) NSDictionary *params;
@end



@implementation HBBEssenceBaseTableViewController



- (NSMutableArray *)topics{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
}

static NSString * const HBBEssenceTopicID = @"essenceTopic";
/**
 *  初始化
 */
- (void)setupTableView{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = HBBTitlesViewH + HBBTitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBBEssenceTopicCell class]) bundle:nil] forCellReuseIdentifier:HBBEssenceTopicID];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    //自动改变hearder透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //进入自动刷新
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

/**
 *  加载更多数据
 */
- (void)loadMoreData{
    
    [self.tableView.mj_header endRefreshing];
    
    //初始化page
    self.page++;
    
    //参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    param[@"page"] = @(self.page);
    param[@"maxtime"] = self.maxtime;
    self.params = param;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != param) {
            return ;
        }
        //字典转模型
        NSArray *newTopics = [HBBEssenceTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newTopics];
        
        //存储加载下一页时所需的参数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //刷新数据
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != param) {
            return ;
        }
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}

/**
 *  加载新的数据
 */
- (void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    self.params = param;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != param) {
            return ;
        }
        
        //字典转模型
        self.topics = [HBBEssenceTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //存储加载下一页时的参数
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //刷新数据
        [self.tableView reloadData];
        
        //初始化page
        self.page = 0;
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != param) {
            return ;
        }
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBBEssenceTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:HBBEssenceTopicID];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出模型
    HBBEssenceTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}
@end
