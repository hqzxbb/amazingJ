//
//  HBBAddTagViewController.m
//  amazingJ
//
//  Created by huangbins on 6/11/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBAddTagViewController.h"
#import "HBBTagButton.h"
#import "HBBTagTextField.h"
#import <SVProgressHUD.h>

@interface HBBAddTagViewController ()<UITextFieldDelegate>
/**
 *  内容
 */
@property (nonatomic, weak) UIView *contentView;
/**
 *  文本输入框
 */
@property (nonatomic, weak) HBBTagTextField *textField;
/**
 *  添加标签按钮
 */
@property (nonatomic, weak) UIButton *addBtn;
/**
 *  所有标签按钮
 */
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation HBBAddTagViewController


/**
 *  懒加载
 */
- (NSMutableArray *)tagButtons{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

/**
 *  懒加载
 */
- (UIButton *)addBtn{
    if (!_addBtn) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.width = self.contentView.width;
        addBtn.height = 35;
        [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        addBtn.titleLabel.font = HBBTagFont;
        addBtn.contentEdgeInsets = UIEdgeInsetsMake(0, HBBTagMargin, 0, HBBTagH);
        
        //让按钮内部的文字和图片都左对齐
        addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addBtn.backgroundColor = HBBTagBg;
        [self.contentView addSubview:addBtn];
        _addBtn = addBtn;
    }
    return _addBtn;
}


/**
 *  初始化
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置内容
    [self setupContentView];
    
    //设置textField
    [self setupTextField];
    
    //设置tags
    [self setupTags];
}

/**
 *      设置导航栏
 */
- (void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

/**
 *  设置contentView
 */
- (void)setupContentView{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = HBBTagMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.y = 64 + HBBTagMargin;
    contentView.height = HBBScreenH;
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

/**
 *  设置textField
 */
- (void)setupTextField{
    __weak typeof(self) weakSelf = self;
    HBBTagTextField *textField = [[HBBTagTextField alloc] init];
    textField.width = self.contentView.width;
    textField.deleteBlock = ^{
        if (weakSelf.textField.hasText) return ;
        [weakSelf tagBtnClick:[weakSelf.tagButtons lastObject]];
    };
    textField.delegate = self;
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.contentView addSubview:textField];
    self.textField = textField;
}

/**
 *  设置tags
 */
- (void)setupTags{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addBtnClick];
    }
}


#pragma mark - 自定义方法

/**
 *  添加tag按钮点击
 */
- (void)addBtnClick{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return;
    }
    
    //添加一个“标签按钮”
    HBBTagButton *tagButton = [HBBTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    
    //清空textField文字
    self.textField.text = nil;
    self.addBtn.hidden = YES;
    
    //更新标签按钮的Frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

/**
 *  tag按钮点击
 */
- (void)tagBtnClick:(UIButton *)btn{
    [btn removeFromSuperview];
    [self.tagButtons removeObject:btn];
    
    //更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

/**
 *  监听textField文字改变
 */
- (void)textDidChange{
    //更新文本框的frame
    [self updateTextFieldFrame];
    
    if (self.textField.hasText) {//有文字
        //显示添加标签按钮
        self.addBtn.hidden = NO;
        self.addBtn.y = CGRectGetMaxY(self.textField.frame) + HBBTagMargin;
        [self.addBtn setTitle:[NSString stringWithFormat:@"添加标签：%@", self.textField.text] forState:UIControlStateNormal];
        
        //获取最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString * lastLetter = [text substringFromIndex:len-1];
        if ([lastLetter isEqualToString:@"，"] || [lastLetter isEqualToString:@","]) {
            //去掉逗号
            self.textField.text = [text substringToIndex:len-1];
            
            [self addBtnClick];
        }
    }else{//没文字
        //隐藏添加标签按钮
        self.addBtn.hidden = YES;
    }
}

- (void)updateTagButtonFrame{
    //更新标签的frame
    for (int i = 0; i < self.tagButtons.count; i++) {
        HBBTagButton *tagBtn = self.tagButtons[i];
        
        if (i == 0) {//最前面的标签按钮
            tagBtn.x = 0;
            tagBtn.y = 0;
        }else{//其他标签按钮
            HBBTagButton *lastBtn = self.tagButtons[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastBtn.frame) + HBBTagMargin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagBtn.width) {
                tagBtn.x = leftWidth;
                tagBtn.y = lastBtn.y;
            }else{
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY(lastBtn.frame) + HBBTagMargin;
            }
        }
    }
}

- (void)updateTextFieldFrame{
    //最后一个标签按钮
    HBBTagButton *lastTagBtn = [self.tagButtons lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagBtn.frame) + HBBTagMargin;
    
    //更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastTagBtn.y;
        self.textField.x = leftWidth;
    }else{
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagBtn.frame) + HBBTagMargin;
    }
}

/**
 *  textFiew的文字宽度
 */
- (CGFloat)textFieldTextWidth{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName: self.textField.font}].width;
    return MAX(100, textW);
}

- (void)done{
    //传递tags给这个block
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock?:self.tagsBlock(tags);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
