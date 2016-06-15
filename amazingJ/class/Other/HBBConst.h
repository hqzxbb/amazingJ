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
/**
 *  User模型用户的性别属性
 */
UIKIT_EXTERN NSString * const HBBUserSexMale;
UIKIT_EXTERN NSString * const HBBUserSexFemale;



/**
 *  精华-cell-最热评论标题的高度
 */
UIKIT_EXTERN CGFloat const HBBTopicCellTopCmtTitleH;
/**
 *  tabBar被选中的通知的名字
 */
UIKIT_EXTERN NSString * const HBBTabBarDidSelectNotifacation;
/**
 *   tabBar被选中的通知-被选中的控制器的index key
 */
UIKIT_EXTERN NSString * const HBBSelectedControllerIndexKey;
/**
 *  tabBar被选中的通知-被选中的控制器key
 */
UIKIT_EXTERN NSString * const HBBSelectedControllerKey;

/**
 *  标签间距
 */
UIKIT_EXTERN CGFloat const HBBTagMargin;
/**
 *  标签高度
 */
UIKIT_EXTERN CGFloat const HBBTagH;








