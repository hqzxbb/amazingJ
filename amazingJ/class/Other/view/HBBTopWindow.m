//
//  HBBTopWindow.m
//  amazingJ
//
//  Created by huangbins on 4/15/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBTopWindow.h"

@implementation HBBTopWindow

static UIWindow *topwindow;

+ (void)initialize{
    topwindow = [[UIWindow alloc] init];
    topwindow .frame = CGRectMake(0, 0, HBBScreenW, 20);
    topwindow.windowLevel = UIWindowLevelAlert;
    topwindow.backgroundColor = [UIColor clearColor];
    [topwindow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    topwindow.hidden = YES;
}

/**
 *  监听窗口点击
 */
+ (void)windowClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superView{
    for (UIScrollView *subview in superView.subviews) {
        //如果是scrollView,滚动到最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        //继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

+ (void)show{
    topwindow.hidden = NO;
}

+ (void)hide{
    topwindow.hidden = YES;
}
@end
