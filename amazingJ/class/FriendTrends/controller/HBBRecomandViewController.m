//
//  HBBRecomandViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/16.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBRecomandViewController.h"
#import "HBBRecomandCategoryCell.h"
#import "HBBRecomandCategory.h"
#import "HBBReconmandUserCell.h"
#import "HBBRecommendUser.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>

@interface HBBRecomandViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  类别数组
 */
@property (nonatomic,strong)NSArray *categories;

/**
 *  左边类别view
 */
@property (weak, nonatomic) IBOutlet UITableView *leftview;

/**
 *  右边用户详情view
 */
@property (weak, nonatomic) IBOutlet UITableView *rightView;

/**
 *  请求参数
 */
@property (nonatomic,strong)NSMutableDictionary *params;

/**
 *  AFN的请求管理者
 */
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation HBBRecomandViewController

static NSString *const HBBCategoryID = @"category";
static NSString *const HBBUserID = @"user";


- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"推荐关注";
    
    //初始化tableView
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求加载类别
    [self setupCategorys];
    
}

/**
 *  初始化类别数组
 */
- (void)setupCategorys{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.categories = [HBBRecomandCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //加载数据成功刷新表格
        [self.leftview reloadData];
        
        //默认选中首行
        [self.leftview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:nil scrollPosition:UITableViewScrollPositionTop];
        
        //选中的首行进入下拉刷新状态
        [self.rightView.mj_header beginRefreshing];
        
        //加载成功隐藏指示器
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        HBBLog(@"%@",error);
        
        //加载失败显示错误信息
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        
    }];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh{
    
    self.rightView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.rightView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

/**
 *  加载最新数据
 */
- (void)loadNewUsers{
    
    HBBRecomandCategory *category = self.categories[self.leftview.indexPathForSelectedRow.row];
    
    //设置当前的页码为1
    category.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(category.currentPage);
    
    self.params = params;
    
    //发送请求给服务器，加载右侧的数据
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) {
            return ;
        }
        
        //字典数组转为模型数组
        NSArray *users =[HBBRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有旧数据
        [category.users removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //保存users总数
        category.total = [responseObject[@"total"] integerValue];
        
        //判断是否还有下一页数据
        if ((int)category.users.count == (int)category.total) {
            [self.rightView.mj_footer endRefreshingWithNoMoreData];
        }
        
        //刷新右边的表格
        [self.rightView reloadData];
        
        //结束刷新
        [self.rightView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) {
            return ;
        }
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //结束刷新
        [self.rightView.mj_header endRefreshing];
    }];

}

/**
 *  加载更多数据
 */
- (void)loadMoreUsers{
    //发送请求
    HBBRecomandCategory *category = self.categories[self.leftview.indexPathForSelectedRow.row];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) {
            return ;
        }
        
        //字典数组转为模型数组
        NSArray *users =[HBBRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //刷新右边的表格
        [self.rightView reloadData];
        
        //结束刷新
        if((int)category.users.count == (int)category.total){
            [self.rightView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.rightView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (self.params != params) {
            return ;
        }
        
        //提示
        [SVProgressHUD showErrorWithStatus:@"加载用户信息失败"];
        
        //让底部控件结束刷新
        [self.rightView.mj_footer endRefreshing];
    }];

}

/**
 *  初始化tableView
 */
- (void)setupTableView{
    
    //注册nib
    [self.leftview registerNib:[UINib nibWithNibName:NSStringFromClass([HBBRecomandCategoryCell class]) bundle:nil] forCellReuseIdentifier:HBBCategoryID];
    
    [self.rightView registerNib:[UINib nibWithNibName:NSStringFromClass([HBBReconmandUserCell class]) bundle:nil] forCellReuseIdentifier:HBBUserID];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //设置背景
    self.view.backgroundColor = HBBGlobalRGB;
}

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.leftview) {

        return self.categories.count;
        
    }else{
        
        HBBRecomandCategory *category = self.categories[self.leftview.indexPathForSelectedRow.row];

        //每次刷新右边数据时，都控制footer显示或者隐藏
        self.rightView.mj_footer.hidden = (category.users.count == 0);
        
        //左边被选中的类别模型
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.leftview) {
        HBBRecomandCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:HBBCategoryID];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else{
        HBBReconmandUserCell *cell = [tableView dequeueReusableCellWithIdentifier:HBBUserID];
        
        HBBRecomandCategory *category = self.categories[self.leftview.indexPathForSelectedRow.row];
        
        cell.user = category.users[indexPath.row];
        
        return cell;
    }
    
}


#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.rightView.mj_header endRefreshing];
    
    [self.rightView.mj_footer endRefreshing];
    
    HBBRecomandCategory *category = self.categories[indexPath.row];
    
    if (category.users.count) {
        
        //加载之前数据
        [self.rightView reloadData];
        
    }else{
        
        //刷新表格，使上一个category的数据消失
        [self.rightView reloadData];
        
        //进入下拉刷新状态
        [self.rightView.mj_header beginRefreshing];
        
        }
    
}

#pragma mark - 控制器的销毁
- (void)dealloc{
    //取消所有网络请求操作
    [self.manager.operationQueue cancelAllOperations];
}




@end
