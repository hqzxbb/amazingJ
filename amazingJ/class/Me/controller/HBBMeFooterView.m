//
//  HBBMeFooterView.m
//  amazingJ
//
//  Created by huangbins on 6/28/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBMeFooterView.h"
#import <AFNetworking.h>
#import "HBBSquare.h"
#import "HBBSquareButton.h"
#import "HBBMeWebViewController.h"
#import <MJExtension.h>


@implementation HBBMeFooterView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //设置参数
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"a"] = @"square";
        param[@"c"] = @"topic";
        
        //发送请求
        [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            NSArray *squares = [HBBSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];

            // 创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
    return self;
    
}


- (void)createSquares:(NSArray *)squares{
    
    //一行最多4列
    int maxCols = 4;
    
    //宽度和高度
    CGFloat btnWidth = HBBScreenW/maxCols;
    CGFloat btnHeight = btnWidth;
    
    //创建方块按钮
    for (int i = 0 ; i < squares.count; i++) {
        //创建按钮
        HBBSquareButton *btn = [HBBSquareButton buttonWithType:UIButtonTypeCustom];
        
        //监听点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //传递数据模型
        btn.square = squares[i];
        [self addSubview:btn];
        
        //计算frame
        int col = i%maxCols;
        int row = i/maxCols;
        
        btn.width =  btnWidth;
        btn.height = btnHeight;
        btn.x = col * btnWidth;
        btn.y = row * btnHeight;
    }
    
    //总行数
    NSInteger rowCount = (squares.count + maxCols - 1)  /  maxCols;
    
    //计算footer的高度
    self.height = rowCount * btnHeight;
//    HBBLog(@"%f", self.height);
//    HBBLog(@"%f", HBBScreenH);
    
    //重绘
    [self setNeedsDisplay];
    
}

- (void)btnClick:(HBBSquareButton *)btn{
    if (![btn.square.url hasPrefix:@"http:"]) {
        return;
    }
    
    HBBMeWebViewController *webVC = [[HBBMeWebViewController alloc] init];
    webVC.url = btn.square.url;
    webVC.title = btn.square.name;
    
    //取出当前控制器
    UIViewController *currentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UITabBarController *tabBarVC = (UITabBarController *)currentVC;
    UINavigationController *nav = (UINavigationController*)tabBarVC.selectedViewController;
    
    [nav pushViewController:webVC animated:YES];
    
}

@end
