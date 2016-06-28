//
//  HBBCommentViewController.m
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBCommentViewController.h"
#import "HBBEssenceTopicCell.h"
#import "HBBEssenceTopic.h"
#import "HBBEssenceComment.h"
#import "HBBEssenceCommentCell.h"
#import "HBBEssenceCommentHeaderView.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>

static NSString * const HBBCommentID = @"comment";

@interface HBBCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  工具条底部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textBottomLayout;

/**
 *  最热评论
 */
@property (nonatomic, strong) NSArray *hotComments;

/**
 *  最新评论
 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/**
 *  保存帖子的top_cmt
 */
@property (nonatomic, strong) HBBEssenceComment *saved_top_cmt;

/**
 *  保存当前的页码
 */
@property (nonatomic, assign) NSInteger page;

/** 
 * httpmanager
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation HBBCommentViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    
}

- (void)setupBasic{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //cell的高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //背景色
    self.tableView.backgroundColor = HBBGlobalRGB;
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HBBEssenceCommentCell class]) bundle:nil] forCellReuseIdentifier:HBBCommentID];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, HBBTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification*)note{
    //键盘显示/隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //修改底部约束
    self.textBottomLayout.constant = HBBScreenH - frame.origin.y;
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)setupHeader{
    //创建header
    UIView *header = [[UIView alloc] init];
    
    //清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    //添加cell
    HBBEssenceTopicCell *cell = [HBBEssenceTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(HBBScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度
    header.height = self.topic.cellHeight + HBBTopicCellMargin;
    
    //设置header
    self.tableView.tableHeaderView = header;
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments{
    //结束之前所有的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //页码
    NSInteger page = self.page + 1;
    
    //参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"data_id"] = self.topic.ID;
    param[@"page"] = @(page);
    HBBEssenceComment *cmt = [self.latestComments lastObject];
    param[@"lastcid"] = cmt.ID;
    
    //发送请求
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return ;
        }
        
        //最新评论
        NSArray *newComments = [HBBEssenceComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        //页码
        self.page = page;
        
        //刷新数据
        [self.tableView reloadData];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }else{
            //结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewComments{
    //结束之前所有的网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"data_id"] = self.topic.ID;
    param[@"hot"] = @"1";
    
    //发送请求
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        //最热评论
        self.hotComments = [HBBEssenceComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
         self.latestComments = [HBBEssenceComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //页码
        self.page = 1;
        
        //刷新数据
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //恢复帖子的最热评论
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    //取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
    
}

/**
 *  返回第section组所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (HBBEssenceComment *)commentIndexPath:(NSIndexPath *)indexPath{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma make- <UITableViewDateSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) {
        return 2;
    }
    if (latestCount) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    //隐藏尾部控件
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    
    //非第0组
    return latestCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBBEssenceCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:HBBCommentID];
    
    cell.comment = [self commentIndexPath:indexPath];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //先从缓存池中找header
    HBBEssenceCommentHeaderView *header = [HBBEssenceCommentHeaderView headerViewWithTableView:tableView];
    
    //设置label数据
    NSInteger hotCount = self.hotComments.count;
    
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    }else{
        header.title = @"最新评论";
    }
    return header;
}


#pragma make - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        //被点击的cell
        HBBEssenceCommentCell *cell = (HBBEssenceCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        //出现一个第一响应者
        [cell becomeFirstResponder];
        
        //显示menucontroller
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *reply = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        
        menu.menuItems = @[ding, reply, report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma make -<UIMenuItem>
- (void)ding:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HBBLog(@"%s %@", __func__, [self commentIndexPath:indexPath].content);
}
- (void)reply:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HBBLog(@"%s %@", __func__, [self commentIndexPath:indexPath].content);
}
- (void)report:(UIMenuController *)menu{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    HBBLog(@"%s %@", __func__, [self commentIndexPath:indexPath].content);
}

@end
