//
//  HBBEssenceTopicCell.m
//  amazingJ
//
//  Created by huangbins on 16/3/26.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBEssenceTopicCell.h"
#import "HBBEssenceTopic.h"
#import <UIImageView+WebCache.h>
#import "HBBEssenceTopicPictureView.h"


@interface HBBEssenceTopicCell()
/**
 *  帖子的正文
 */
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/**
 *  新浪加V认证
 */
@property (weak, nonatomic) IBOutlet UIImageView *sina_v;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/**
 *  分享转发
 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

/**
 *  cell图片内容
 */
@property (nonatomic, weak) HBBEssenceTopicPictureView *picutreView;

@end


@implementation HBBEssenceTopicCell

- (HBBEssenceTopicPictureView *)picutreView{
    if (!_picutreView) {
        HBBEssenceTopicPictureView *picutre = [HBBEssenceTopicPictureView pictureView];
        [self.contentView addSubview:picutre];
        _picutreView = picutre;
    }
    return _picutreView;
}

- (void)awakeFromNib{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(HBBEssenceTopic *)topic{
    _topic = topic;
    
    //设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.sina_v.hidden = !topic.isSina_v;
        
    //设置按钮文字
    [self setupButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareBtn count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];

    //设置帖子的正文
    self.text_Label.text = topic.text;
    
    //根据帖子类型添加对应的内容到cell中
    if (topic.type == HBBTopicTypePicture) {
        self.picutreView.topic = topic;
        self.picutreView.frame = topic.picture_frame;
    }
}

/**
 *  设置按钮文字
 *
 *  @param btn         按钮
 *  @param count       数量
 *  @param placeholder 文字
 */
- (void)setupButtonTitle:(UIButton *)btn count:(NSInteger)count  placeholder:(NSString *)placeholder{
    NSString *title = nil;
    
    if (count == 0) {
        title = [NSString stringWithString:placeholder];
    }else if (count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万", count/10000.0];
    }else{
        title = [NSString stringWithFormat:@"%zd", count];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

/**
 *  重写setframe方法修改cell位置尺寸
 */
- (void)setFrame:(CGRect)frame{
    
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
