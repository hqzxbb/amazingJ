//
//  HBBPublicViewController.m
//  amazingJ
//
//  Created by huangbins on 3/30/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBPublicViewController.h"
#import "HBBVerticalButton.h"
#import <POP.h>
static CGFloat const HBBAnimationDelay = 0.1;
static CGFloat const HBBSpringFactor = 10;

@interface HBBPublicViewController ()

@end

@implementation HBBPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让控制器的view不能点击
    self.view.userInteractionEnabled = NO;
    
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //添加中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (HBBScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (HBBScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols -1);
    for (int i = 0; i < images.count; i ++ ) {
        HBBVerticalButton *button = [[HBBVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //计算x，y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - HBBScreenH;
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX,buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = HBBSpringFactor;
        anim.springSpeed = HBBSpringFactor;
        anim.beginTime = CACurrentMediaTime() + i * HBBAnimationDelay;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //添加slogan
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    //添加slogan动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = HBBScreenW * 0.5;
    CGFloat centerEndY = HBBScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - HBBScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * HBBAnimationDelay;
    anim.springBounciness = HBBSpringFactor;
    anim.springSpeed = HBBSpringFactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        //标语动画执行完毕，恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button{
    
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}


/**
 *  先执行退出动画，动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void(^)())completionBlock{
    //让控制器不能点击
    self.view.userInteractionEnabled = YES;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + HBBScreenH;
        
        //动画的执行节奏
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * HBBAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                //执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletionBlock:nil];
}



@end
