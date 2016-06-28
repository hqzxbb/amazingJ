//
//  HBBEssenceTopic.h
//  amazingJ
//
//  Created by huangbins on 16/3/25.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKIt/UIKit.h>
@class HBBEssenceComment;
@interface HBBEssenceTopic : NSObject
/**
 *  id
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *profile_image;
/**
 *  发帖时间
 */
@property (nonatomic, copy) NSString *create_time;
/**
 *  文字内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  顶的数量
 */
@property (nonatomic, assign) NSInteger ding;
/**
 *  踩得数量
 */
@property (nonatomic, assign) NSInteger cai;
/**
 *  转发的数量
 */
@property (nonatomic, assign) NSInteger repost;
/**
 *  评论的数量
 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  新浪加V认证
 */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;
/**
 *  图片的宽度
 */
@property (nonatomic, assign) CGFloat image_width;
/**
 *  图片的高度
 */
@property (nonatomic, assign) CGFloat image_height;
/**
 *  小图片的URL
 */
@property (nonatomic, copy) NSString *small_image;
/**
 *  大图片的URL
 */
@property (nonatomic, copy) NSString *large_image;
/**
 *  中图片的URL
 */
@property (nonatomic, copy) NSString *middle_image;
/**
 *  帖子类型
 */
@property (nonatomic, assign) HBBTopicType type;
/**
 *  音频时长
 */
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  视频时长
 */
@property (nonatomic, assign) NSInteger videotime;
/**
 *  播放次数
 */
@property (nonatomic, assign) NSInteger playcount;



/****************  comment  *******************/
/**
 *  最热评论
 */
@property (nonatomic, strong) HBBEssenceComment *top_cmt;


/****************  comment  *******************/


/****************  frame  *******************/
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**
 *  图片的frame
 */
@property (nonatomic, assign, readonly) CGRect picture_frame;
/**
 *  是否是大图
 */
@property (nonatomic, assign, getter=isBigPicture) BOOL isBigPicture;
/**
 *  图片的下载进度
 */
@property (nonatomic, assign) CGFloat picture_progress;
/**
 *  声音的frame
 */
@property (nonatomic, assign, readonly) CGRect voice_frame;
/**
 *  视频的frame
 */
@property (nonatomic, assign, readonly) CGRect video_frame;
@end
