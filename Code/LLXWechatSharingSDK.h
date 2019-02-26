//
//  LLXWechatSharingSDK.h
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXBaseSharingSDK.h"
#import "WXApi.h"
typedef enum : NSUInteger {
    XXWechatSharingSceneSession  = 0,        /**< 微信聊天界面    */
    XXWechatSharingSceneTimeline = 1,        /**< 微信朋友圈      */
    XXWechatSharingSceneFavorite = 2,        /**< 微信收藏       */
} XXWechatSharingScene;

@interface LLXWechatSharingSDK : LLXBaseSharingSDK
/**
 *  分享多媒体到微信
 *
 *  @param message 要分享的message
 *  @param where   分享到微信的指定场景，默认分享到微信聊天界面
 */
+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message toWhere:(XXWechatSharingScene)where;

/**
 *  分享文本到微信
 *
 *  @param text  要分享的文本
 *  @param where 分享到微信的指定场景，默认分享到微信聊天界面
 */
+(void)shareWithText:(NSString *)text toWhere:(XXWechatSharingScene)where;

@end
