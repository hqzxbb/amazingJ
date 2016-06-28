//
//  HBBPostWordViewController.m
//  amazingJ
//
//  Created by huangbins on 5/19/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBPostWordViewController.h"
#import "HBBPlaceHolderTextView.h"
#import "HBBAddTagToolbar.h"

@interface HBBPostWordViewController ()<UITextViewDelegate>
/**
 *  文字输入控件
 */
@property (nonatomic, weak) HBBPlaceHolderTextView  *textView;

/**
 *  工具条
 */
@property (nonatomic, weak) HBBAddTagToolbar *toolbar;

@end

@implementation HBBPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航栏样式
    [self setupNav];
    
    //设置textView
    [self setupTextView];
    
    //设置键盘上部工具条
    [self setupToolBar];
    
}

/**
 *  设置工具条
 */
- (void)setupToolBar{
    //键盘上部的toolBar
    HBBAddTagToolbar *toolBar = [HBBAddTagToolbar viewFromNib];
    toolBar.width = self.view.width;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolbar = toolBar;
    
    //添加监听
    [HBBNotificationCenter addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  监听到键盘frame将要改变就执行这个方法
 *
 *  @param note 键盘改变的info
 */
- (void)keyBoardWillChangeFrame:(NSNotification*)note{
    //键盘的最终frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //键盘上部工具条动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - HBBScreenH);
    }];
}

/**
 *  设置导航栏样式
 */
- (void)setupNav{
    self.title = @"发段子";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar layoutIfNeeded];
}


/**
 *  设置textView
 */
- (void)setupTextView{
    HBBPlaceHolderTextView *textView = [[HBBPlaceHolderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.placeholderText = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
}


- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)post{
    HBBLogFunc;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    
    //先退出之前的键盘
    [self.view endEditing:YES];
    
    //再叫出键盘
    [self.textView becomeFirstResponder];

}


#pragma mark - UITextViewDelegate
/**
 *  有文字是发送按钮可点击
 */
- (void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

/**
 *  滚动屏幕时退出键盘
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
