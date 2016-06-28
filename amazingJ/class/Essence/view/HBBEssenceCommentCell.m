//
//  HBBEssenceCommentCell.m
//  amazingJ
//
//  Created by huangbins on 4/12/16.
//  Copyright © 2016 HBB. All rights reserved.
//

#import "HBBEssenceCommentCell.h"
#import "HBBEssenceComment.h"
#import "HBBEssenceUser.h"
#import <UIImageView+WebCache.h>
#import "UIImage+HBBImageMask.h"

@interface HBBEssenceCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation HBBEssenceCommentCell

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(HBBEssenceComment *)comment {
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image = image ? [image circleImage] : [UIImage imageNamed:@"defaultUserIcon"];
    }];
    
    self.sexView.image = [comment.user.sex isEqualToString:HBBUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] :
    [UIImage imageNamed:@"Profile_womanIcon"];
    
    self.contentLabel.text = comment.content;
    
    self.usernameLabel.text = comment.user.username;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
    
}

@end
