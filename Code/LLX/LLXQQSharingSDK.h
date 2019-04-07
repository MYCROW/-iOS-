//
//  LLXQQSharingSDK.h
//  XXAppStore
//
//  Created by WangMao on 16/8/7.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXBaseSharingSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
typedef enum : NSUInteger {
    LLQQSharingSceneQQ       = 0,        /**< 分享到QQ    */
    LLQQSharingSceneQQZone   = 1,        /**< 分享到QQ空间      */
} LLQQSharingScene;

@interface LLXQQSharingSDK : LLXBaseSharingSDK

/**
 *  分享多媒体到QQ
 *
 *  @param message 要分享的message
 *  @param where   分享到QQ
 */
+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message toWhere:(LLQQSharingScene)where;

/**
 *  分享文本到QQ
 *
 *  @param text  要分享的文本
 *  @param where 分享到QQ空间
 */
+(void)shareWithText:(NSString *)text toWhere:(LLQQSharingScene)where;


/**
 发送QQ临时会话

 @param qqNumber 临时会话的QQ号
 */
+ (void)sentToQQWPAWithQQNumber:(NSString *)qqNumber;

/**
  加入Q群
 
 @param qqGroup Q群号
 */
+ (void)sentToJoinGrouWithQQGroup:(NSString *)qqGroup;

@end
