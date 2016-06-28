//
//  HBBPlaceHolderTextView.m
//  amazingJ
//
//  Created by huangbins on 5/19/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBPlaceHolderTextView.h"
@interface HBBPlaceHolderTextView()
/**
 *  占位文字label
 */
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation HBBPlaceHolderTextView

/**
 *  懒加载
 */
- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return  _placeholderLabel;
}

/**
 *  初始化textView
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //垂直方向上始终有弹簧效果
        self.alwaysBounceVertical = YES;
        
        //默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        //默认占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        //监听文字改变
        [HBBNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}

/**
 *  销毁时移除通知中心
 */
- (void)dealloc{
    [HBBNotificationCenter removeObserver:self];
}

/**
 *  监听文字改变
 */
- (void)textDidChange{
    //只要有文字就隐藏placeholder
    self.placeholderLabel.hidden = self.hasText;
}

/**
 *  更新占位文字label的尺寸
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    
    [self.placeholderLabel sizeToFit];
}

#pragma mark - setter方法

- (void)setPlaceholderText:(NSString *)placeholderText{
    _placeholderText = [placeholderText copy];
    
    self.placeholderLabel.text = placeholderText;
    
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
    
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}



@end
