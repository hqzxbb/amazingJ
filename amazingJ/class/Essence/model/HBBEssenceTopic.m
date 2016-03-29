//
//  HBBEssenceTopic.m
//  amazingJ
//
//  Created by huangbins on 16/3/25.
//  Copyright © 2016年 HBB. All rights reserved.
//

#import "HBBEssenceTopic.h"
#import <MJExtension.h>

@implementation HBBEssenceTopic
{
    CGFloat _cellHeight;
    CGRect _picture_frame;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"small_image" : @"image0", @"large_image" : @"image1", @"middle_image" : @"image2", @"image_width" : @"width",  @"image_height" : @"height"};
}

- (NSString *)create_time{
    //修改发帖时间显示
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [fmt dateFromString:_create_time];
    //计算相差时间
    if (create.isThisYear) {//今年
        if (create.isToday) {//今天
            NSDateComponents *cmps = [[NSDate date] delateFrom:create];
            if (cmps.hour >= 1) {//时间差距大于1小时
                _create_time = [NSString stringWithFormat:@"%zd 小时前",cmps.hour];
            }else if(cmps.minute >= 1){//时间差距小于1小时，大于1分钟
                _create_time = [NSString stringWithFormat:@"%zd 分钟前", cmps.minute];
            }else{//时间差距小于1分钟
                _create_time  = @"刚刚";
            }
        }else if(create.isYestorday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            _create_time = [fmt stringFromDate:create];
        }else{//其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            _create_time= [fmt stringFromDate:create];
        }
    }else{//不是今年
        return _create_time;
    }
    
    return _create_time;
}

- (CGFloat)cellHeight{
    if (!_cellHeight) {
        
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * HBBTopicCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //cell的文字部分的高度
        _cellHeight = HBBTopicCellTextY + textH + HBBTopicCellMargin;
        
        //根据帖子的类型来计算图片的高度
        if (self.type == HBBTopicTypePicture) {
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH= pictureW * self.image_height / self.image_width;
            
            
            //判断图片是否是大图
            if (pictureH > HBBTopicCellPictureMaxH) {
                pictureH = HBBTopicCellPictureBreakH;
                self.isBigPicture  = YES;
            }
            //cell到图片控件底部的高度
            _cellHeight += pictureH + HBBTopicCellMargin;
            
            //计算图片控件的frame
            CGFloat pictureX = HBBTopicCellMargin;
            CGFloat pictureY = HBBTopicCellTextY + textH + HBBTopicCellMargin;
            _picture_frame = CGRectMake(pictureX,  pictureY, pictureW, pictureH);
            
         
        }
        
        //再加上底部工具条的高度
        _cellHeight += HBBTopicCellBottomBarH + HBBTopicCellMargin;
    }
    return _cellHeight;
}
@end
