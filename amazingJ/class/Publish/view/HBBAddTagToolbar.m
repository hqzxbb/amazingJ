//
//  HBBAddTagToolbar.m
//  amazingJ
//
//  Created by huangbins on 6/11/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBAddTagToolbar.h"
#import "HBBAddTagViewController.h"


@interface HBBAddTagToolbar()

/**
 *  顶部的view
 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  添加按钮
 */
@property (nonatomic, weak) UIButton *addButton;
/**
 *  存放所有的标签
 */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end
@implementation HBBAddTagToolbar

- (NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (void)awakeFromNib{
    //添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addButton.size = addButton.currentImage.size;
    addButton.x = HBBTagMargin;
    [self.topView addSubview:addButton];
    self.addButton = addButton;
    
    //默认的两个标签
    [self creatTagLabels:@[@"糗事",@"吐槽"]];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
    
        //设置位置
        if (i == 0) {//最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        }else{//其他标签
            UILabel *lastTagLabel = self.tagLabels[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + HBBTagMargin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth > tagLabel.width) {//显示在当前行
                tagLabel.x = leftWidth;
                tagLabel.y = lastTagLabel.y;
            }else{//显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + HBBTagMargin;
            }
        }
    }

    //最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + HBBTagMargin;

    //更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + HBBTagMargin;
    }

    //直接修改self的高度
    CGFloat oldH = self.height;

    self.height = CGRectGetMaxY(self.addButton.frame) + 45;

    self.y -= self.height - oldH;

}


/**
 *  添加标签按钮点击出发事件
 */
- (void)addButtonClick{
    HBBAddTagViewController *addTagVC = [[HBBAddTagViewController alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [addTagVC setTagsBlock:^(NSArray *tags) {
        [weakSelf creatTagLabels:tags];
    }];
    
    addTagVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController*)root.presentedViewController;
    [nav pushViewController:addTagVC animated:YES];
}

/**
 *  创建tags
 */
- (void)creatTagLabels:(NSArray*)tags{
    //每次都清空上一次创建的所有tags
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    //遍历tags数组创建tagsLabel并计算位置
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = HBBTagBg;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = HBBTagFont;
        //先设置文字和字体之后再计算label大小
        [tagLabel sizeToFit];
        tagLabel.width += 2*HBBTagMargin;
        tagLabel.height = HBBTagH;
        tagLabel.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLabel];
    }
    
    //重新布局子控件
    [self setNeedsLayout];
}






@end
