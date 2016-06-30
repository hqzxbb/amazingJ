//
//  HBBMeWebViewController.m
//  amazingJ
//
//  Created by huangbins on 6/28/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBMeWebViewController.h"
#import <NJKWebViewProgress.h>

@interface HBBMeWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**
 *  页面进度
 */
@property (nonatomic, strong) NJKWebViewProgress *progress;

@end

@implementation HBBMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.webView goBack];
}


- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}


- (IBAction)Refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
}
@end
