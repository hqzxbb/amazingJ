//
//  HBBLoginRegisterViewController.m
//  amazingJ
//
//  Created by huangbins on 16/3/23.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBLoginRegisterViewController.h"

@interface HBBLoginRegisterViewController ()
/**
 *  登录框距离控制器左边的间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation HBBLoginRegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
/**
 *  返回
 */
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  显示登录或者注册
 */
- (IBAction)showLoginOrRegister:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) {
        self.loginViewLeftMargin.constant = -self.view.width;
        button.selected = YES;
    }else{
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

/**
 *  让当前控制器对应的状态栏是白色
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
