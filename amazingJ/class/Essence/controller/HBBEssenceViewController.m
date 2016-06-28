//
//  HBBEssenceViewController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBEssenceViewController.h"
#import "HBBRecommendTagsViewController.h"
#import "HBBEssenceBaseTableViewController.h"
#import "HBBTopWindow.h"

@interface HBBEssenceViewController ()<UIScrollViewDelegate>
/**
 *  标签栏底部红色指示器
 */
@property (nonatomic, weak) UIView *indicatorView;
/**
 *  当前选中按钮
 */
@property (nonatomic, weak) UIButton *selectedButton;
/**
 *  顶部的所有标签
 */
@property (nonatomic, weak) UIView *titlesView;
/**
 *  底部的所有内容
 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation HBBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加一个window，点击这个window，可以让屏幕上的scrollView滚到最顶部
    [HBBTopWindow show];
    
    //设置导航栏的内容
    [self setupNavigationBar];
    
    //初始化子控制器
    [self setupChildVCs];
    
    //设置顶部的标签栏
    [self setupTitlesView];
    
    //设置内容scrollView
    [self setupContentView];
}

/**
 *  初始化子控制器
 */
- (void)setupChildVCs{
    
    HBBEssenceBaseTableViewController *all = [[HBBEssenceBaseTableViewController alloc] init];
    all.type = HBBTopicTypeAll;
    all.title = @"全部";
    [self addChildViewController:all];
    
    HBBEssenceBaseTableViewController *video = [[HBBEssenceBaseTableViewController alloc] init];
    video.type = HBBTopicTypeVideo;
    video.title = @"视频";
    [self addChildViewController:video];
    
    HBBEssenceBaseTableViewController *voice = [[HBBEssenceBaseTableViewController alloc] init];
    voice.type = HBBTopicTypeVoice;
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    HBBEssenceBaseTableViewController *word = [[HBBEssenceBaseTableViewController alloc] init];
    word.type = HBBTopicTypeWord;
    word.title = @"段子";
    [self addChildViewController:word];
    
    HBBEssenceBaseTableViewController *picture = [[HBBEssenceBaseTableViewController alloc] init];
    picture.type = HBBTopicTypePicture;
    picture.title = @"图片";
    [self addChildViewController:picture];
    
}

/**
 *  设置内容scrollView
 */
- (void)setupContentView{
    
    //不自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    //添加第一个子控制器的view到contenView
    [self scrollViewDidEndScrollingAnimation:contentView];
}

/**
 *  设置顶部标签栏
 */
- (void)setupTitlesView{
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.65];
    titlesView.width = self.view.width;
    titlesView.height = HBBTitlesViewH;
    titlesView.y = HBBTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    //底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部的子标签
    NSInteger count = self.childViewControllers.count;
    CGFloat width = titlesView.width/count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.x = i * width;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button layoutIfNeeded];//强制布局
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [titlesView addSubview:button];
        
        //默认选中第一个按钮
        if (i == 0) {
            [button.titleLabel sizeToFit];
            [self titleClick:button];
        }
    }
    //此时才添加指示器，是为了保证指示器是titileView的最后一个子控件
    [titlesView addSubview:indicatorView];
}

/**
 *  初始化导航栏
 */
- (void)setupNavigationBar{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(essenceClick)];
    
    self.view.backgroundColor = HBBGlobalRGB;
}

/**
 *  推荐关注
 */
- (void)essenceClick{
    
    HBBRecommendTagsViewController *recommandTagsVC = [[HBBRecommendTagsViewController alloc] init];
    
    [self.navigationController pushViewController:recommandTagsVC animated:YES];
}

/**
 *  点击标题栏，切换控制器
 */
- (void)titleClick:(UIButton *)button{
    
    //设置选中按钮
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //设置指示器的位置
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x  = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - UIScrollViewDelegate
/**
 *  切换子控制器的view
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    //取出索引对应的子控制器，设置取出的子控制器的frame然后添加到scrollView上
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

/**
 *  scrollView动画停止切换子控制器的View
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //出发按钮点击事件
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
