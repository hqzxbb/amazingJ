//
//  HBBPushGuideView.m
//  amazingJ
//
//  Created by huangbins on 16/3/24.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBPushGuideView.h"

@implementation HBBPushGuideView

+ (instancetype)pushGuideView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (IBAction)IKnowBtnClick {
    [self removeFromSuperview];
}

+ (void)show{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        HBBPushGuideView *guideView = [HBBPushGuideView pushGuideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        //存储当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
