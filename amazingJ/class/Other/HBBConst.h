#import <UIkit/UIkit.h>
/**
 帖子的类型
 */
typedef enum {
    HBBTopicTypeAll = 1,
    HBBTopicTypePicture = 10,
    HBBTopicTypeWord = 29,
    HBBTopicTypeVoice = 31,
    HBBTopicTypeVideo = 41,
} HBBTopicType;

/**
 *  精华-顶部标题高度
 */
UIKIT_EXTERN CGFloat const HBBTitlesViewH;
/**
 *  精华-顶部标题Y值
 */
UIKIT_EXTERN CGFloat const HBBTitlesViewY;
/**
 *  精华-cell的间距
 */
UIKIT_EXTERN CGFloat const HBBTopicCellMargin;
/**
 *  精华-cell文字内容的Y值
 */
UIKIT_EXTERN CGFloat const HBBTopicCellTextY;
/**
 *  精华-cell底部工具条的高度
 */
UIKIT_EXTERN CGFloat const HBBTopicCellBottomBarH;
/**
 *  精华-cell图片帖子的最大高度
 */
UIKIT_EXTERN CGFloat const HBBTopicCellPictureMaxH;
/**
 *  精华-cell图片帖子超过最大高度用这个高度
 */
UIKIT_EXTERN CGFloat const HBBTopicCellPictureBreakH;