//
//  HBBEssenceTopicVideoView.m
//  amazingJ
//
//  Created by huangbins on 3/30/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBEssenceTopicVideoView.h"
#import "HBBEssenceTopic.h"
#import <UIImageView+WebCache.h>
#import "HBBShowBigPictureViewController.h"

@interface HBBEssenceTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

@end

@implementation HBBEssenceTopicVideoView

+ (instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    HBBShowBigPictureViewController *showBigPicture = [[HBBShowBigPictureViewController alloc] init];
    showBigPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBigPicture animated:YES completion:nil];
}

- (void)setTopic:(HBBEssenceTopic *)topic{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.playCount.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    //播放时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
