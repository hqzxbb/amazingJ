//
//  HBBTabBarController.m
//  amazingJ
//
//  Created by 黄宾宾 on 16/3/15.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBTabBarController.h"
#import "HBBNewViewController.h"
#import "HBBFriendTrendsViewController.h"
#import "HBBEssenceViewController.h"
#import "HBBMeViewController.h"
#import "HBBNavigationController.h"
#import "HBBTabBar.h"

@interface HBBTabBarController ()

@end

@implementation HBBTabBarController

+ (void)initialize{
    //设置tabBar item属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控制器
    HBBEssenceViewController *essenceVC = [[HBBEssenceViewController alloc] init];
    [self setupChildVc:essenceVC title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    HBBNewViewController *newVC = [[HBBNewViewController alloc] init];
    [self setupChildVc:newVC title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    HBBFriendTrendsViewController *friendTrendsVC = [[HBBFriendTrendsViewController alloc] init];
    [self setupChildVc:friendTrendsVC title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    HBBMeViewController *meVC = [[HBBMeViewController alloc] init];
    [self setupChildVc:meVC title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //将tabBar改为自定义tabBar
    [self setValue:[[HBBTabBar alloc] init] forKey:@"tabBar"];
    
}

/**
 *  初始化子控制器
 *
 *  @param title         子控制器标题
 *  @param image         子控制器图片
 *  @param selectedImage 子控制器选中图片
 */
-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];    
    HBBNavigationController *nav = [[HBBNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}



@end
