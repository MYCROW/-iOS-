//
//  LLXWechatSharingSDK.m
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXWechatSharingSDK.h"
#import "LLXSocialSharingManager.h"

#import "UIImage+FL_Resizing.h"
#import "FLProgressHUD.h"

#define kWXAppID @"wx7a5fc3d8fba4cebc"

@interface LLXSocialSharingManager (WeChatSDK)<WXApiDelegate>

@end

@implementation LLXWechatSharingSDK

+(void)initSDK {
    [WXApi registerApp:kWXAppID];
}

+(BOOL)isAppInstalled {
    BOOL isAppInstalld = [WXApi isWXAppInstalled];
    if (!isAppInstalld) {
        [FLProgressHUD showFailWithTitle:nil msg:NSLocalizedString(@"您还没有安装微信，请先安装", nil)];
    }
    return isAppInstalld;
}

+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message {
    [[self class] shareWithSharingMessage:message toWhere:XXWechatSharingSceneSession];
}

+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message toWhere:(XXWechatSharingScene)where {
    // 微信绑定时会改变微信的AppID，在分享前需要确保把它改回来
    [WXApi registerApp:kWXAppID];
    if (![[self class] isAppInstalled]) {
        return;
    }
    [[self class] postNotificationWithSharingScene:where];
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    if (where == XXWechatSharingSceneSession) {
        req.scene = WXSceneSession;
    }
    else if(where == XXWechatSharingSceneTimeline) {
        req.scene = WXSceneTimeline;
    }
    else if (where == XXWechatSharingSceneFavorite) {
        req.scene = WXSceneFavorite;
    }
    req.bText = NO;
    req.message = [[self class] wechatMessageWithShareingMessage:message];
    [WXApi sendReq:req];
}

+(void)shareWithText:(NSString *)text {
    [[self class] shareWithText:text toWhere:XXWechatSharingSceneSession];
}

+(void)shareWithText:(NSString *)text toWhere:(XXWechatSharingScene)where {
    // 微信绑定时会改变微信的AppID，在分享前需要确保把它改回来
    [WXApi registerApp:kWXAppID];
    if (![[self class] isAppInstalled]) {
        return;
    }
    [[self class] postNotificationWithSharingScene:where];
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    if (where == XXWechatSharingSceneSession) {
        req.scene = WXSceneSession;
    }
    else if(where == XXWechatSharingSceneTimeline) {
        req.scene = WXSceneTimeline;
    }
    else if (where == XXWechatSharingSceneFavorite) {
        req.scene = WXSceneFavorite;
    }
    req.bText = YES;
    req.text = text;
    [WXApi sendReq:req];
}

+ (WXMediaMessage *)wechatMessageWithShareingMessage:(LLXSocialSharingBaseMessage *)sharingMessage {
    WXMediaMessage *wechatMessage = [WXMediaMessage message];
    wechatMessage.title = sharingMessage.title;
    wechatMessage.description = sharingMessage.content;
    CGFloat maxWidth = 256;
    CGFloat imageHeight = sharingMessage.thumbImage.size.height;
    if (imageHeight > sharingMessage.thumbImage.size.width && imageHeight > 256) {
        maxWidth = 256.0 / imageHeight * sharingMessage.thumbImage.size.width;
    }

    [wechatMessage setThumbImage:[sharingMessage.thumbImage fl_RescaleImageWithMaxWidth:maxWidth]];
    if (sharingMessage.imageData) {
        WXImageObject *imageMessage = [WXImageObject object];
        imageMessage.imageData = sharingMessage.imageData;
        wechatMessage.mediaObject = imageMessage;
    }
    else {
        WXWebpageObject *webpageObject = [WXWebpageObject object];
        webpageObject.webpageUrl = sharingMessage.urlStr;
        wechatMessage.mediaObject = webpageObject;
    }
    return wechatMessage;
}

+ (void)postNotificationWithSharingScene:(XXWechatSharingScene)sharingScene {
    switch (sharingScene) {
        case XXWechatSharingSceneSession:
//            [[NSNotificationCenter defaultCenter] postNotificationName:kXXDidSelectSharePlatformNotification object:kXXSharePlatformName_WeChat];
            break;
        case XXWechatSharingSceneTimeline:
//            [[NSNotificationCenter defaultCenter] postNotificationName:kXXDidSelectSharePlatformNotification object:kXXSharePlatformName_WeChat_Circle];
            break;
        case XXWechatSharingSceneFavorite:
            break;
        default:
            break;
    }
}


+(void)handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:[LLXSocialSharingManager sharedInstance]];
}
@end


