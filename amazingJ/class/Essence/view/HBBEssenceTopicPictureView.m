//
//  HBBEssenceTopicPictureView.m
//  amazingJ
//
//  Created by huangbins on 3/28/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBEssenceTopicPictureView.h"
#import "HBBEssenceTopic.h"
#import <UIImageView+WebCache.h>
#import "HBBProgressView.h"
#import "HBBShowBigPictureViewController.h"

@interface HBBEssenceTopicPictureView()
/**
 *  进度条
 */
@property (weak, nonatomic) IBOutlet HBBProgressView *progressView;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *image;
/**
 *  gif图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *gif;
/**
 *  查看全部按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *seeAllBtn;

@end
@implementation HBBEssenceTopicPictureView

- (void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.image.userInteractionEnabled = YES;
    [self.image addGestureRecognizer:[[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    HBBShowBigPictureViewController *showBigPicture = [[HBBShowBigPictureViewController alloc] init];
    showBigPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBigPicture animated:YES completion:nil];
}

+ (instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(HBBEssenceTopic *)topic{
    _topic = topic;
    //立刻显示图片加载进度，防止因为网速太慢显示其他图片的加载进度
    [self.progressView setProgress:topic.picture_progress animated:NO];
    
    //设置图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        //显示progressView
        self.progressView.hidden = NO;
        //计算加载进度
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:progress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //加载完成隐藏progressView
        self.progressView.hidden = YES;
        //如果是大图，需要对图片进行处理
        if (topic.isBigPicture == NO) {
            return ;
        }
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.picture_frame.size, YES, 0.0);
        
        //将下载完的image对象绘制到图形上下文中
        CGFloat width = topic.picture_frame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得image
        self.image.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    //判断是否为gif格式
    NSString *extension = topic.large_image.pathExtension;
    self.gif.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //判断是否显示点击显示全图按钮
    if (topic.isBigPicture) {
        self.seeAllBtn.hidden = NO;
    }else{
        self.seeAllBtn.hidden = YES;
    }
    
}
@end
