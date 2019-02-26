//
//  LLXSocialSharingManager.h
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLXSocialSharingBaseMessage.h"

typedef NS_ENUM(NSUInteger, LLXSocialSharingPlatform) {
    LLXSocialSharingPlatform_Weibo          = 0,
    LLXSocialSharingPlatform_WeChatSession  = 1, //微信好友
    LLXSocialSharingPlatform_WeChatTimeline = 2, //微信朋友圈
    LLXSocialSharingPlatform_QQ             = 3, //QQ
    LLXSocialSharingPlatform_QQZone         = 4, //QQ空间
};

typedef NS_ENUM(NSUInteger, LLXSocialSharingResult) {
    LLXSocialSharingResult_Fail          = 0, //
    LLXSocialSharingResult_Success       = 1, //
    LLXSocialSharingResult_Cancel        = 2, //
};

extern NSString *const kLLSocialSharingDidFinishNotification; //分享
extern NSString *const kLLXSocialSharingPlatformKey; //分享渠道
extern NSString *const kLLXSocialSharingResultKey;

@interface LLXSocialSharingManager : NSObject
+ (LLXSocialSharingManager *)sharedInstance;
/**
 *  分享多媒体信息到指定社交平台
 *
 *  @param message  要分享的信息
 *  @param platform 社交平台类型
 */
- (void)shareWithMessage:(LLXSocialSharingBaseMessage *)message platform:(LLXSocialSharingPlatform)platform;

/**
 *  分享文本信息到指定社交平台
 *
 *  @param text     要分享的文本
 *  @param platform 社交平台类型
 */
- (void)shareWithText:(NSString *)text platform:(LLXSocialSharingPlatform)platform;

/**
 *  处理社交平台客户端程序通过URL启动果盘游戏时传递的数据
 *
 *  @param url      启动第果盘游戏的URL
 *  @param platform 社交平台类型
 */
- (void)handleOpenURL:(NSURL *)url platform:(LLXSocialSharingPlatform)platform;

@end
