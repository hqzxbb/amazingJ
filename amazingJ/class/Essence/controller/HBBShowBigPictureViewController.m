//
//  HBBShowBigPictureViewController.m
//  amazingJ
//
//  Created by huangbins on 3/29/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBShowBigPictureViewController.h"
#import "HBBEssenceTopic.h"
#import <UIImageView+WebCache.h>
#import "HBBProgressView.h"
#import <SVProgressHUD.h>

@interface HBBShowBigPictureViewController ()
@property (weak, nonatomic) IBOutlet HBBProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation HBBShowBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕的宽度和高度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    //添加imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [imageView addGestureRecognizer: tap];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //图片的宽度和高度
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.image_height / self.topic.image_width;
    
    if (pictureH > screenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    //马上显示图片的下载进度
    [self.progressView setProgress:self.topic.picture_progress animated:NO];
    
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize/expectedSize animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save{
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完成"];
        return;
    }
    
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinshSaveingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinshSaveingWithError:(NSString *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];

    }
}
@end
