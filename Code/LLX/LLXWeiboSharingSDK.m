//
//  LLXWeiboSharingSDK.m
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXWeiboSharingSDK.h"
#import "WeiboSDK.h"
#import "FLProgressHUD.h"
#import "UIImage+FL_Resizing.h"

#import "LLXSocialSharingManager.h"

#define kSinaWeiboAppKey @"2268016653"
#define kSinaWeiboAppSecret @"21fe5768ce9fa53431cd71c0f099d581"
#define kSinaWeiboRedirctURI @"https://api.weibo.com/oauth2/default.html"

@interface LLXSocialSharingManager (WeiboSDK)<WeiboSDKDelegate>

@end


@implementation LLXWeiboSharingSDK

+(void)initSDK {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaWeiboAppKey];
}

+(BOOL)isAppInstalled {
    BOOL isAppInstalled = [WeiboSDK isWeiboAppInstalled];
    if (!isAppInstalled) {
        [FLProgressHUD showFailWithTitle:nil msg:NSLocalizedString(@"您还没有安装微博，请先安装", nil)];
    }
    return isAppInstalled;
}

+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message {
//    [[NSNotificationCenter defaultCenter] postNotificationName:kXXDidSelectSharePlatformNotification object:kXXSharePlatformName_Weibo];
    if (![[self class] isAppInstalled]) {
        return;
    }

    WBMessageObject *weiboMessage = [WBMessageObject message];
    
    if (message.thumbImage) {
        weiboMessage.text = [NSString stringWithFormat:@"%@ %@", message.content, message.urlStr];
        WBImageObject *imageObject = [WBImageObject object];
        imageObject.imageData = UIImageJPEGRepresentation(message.thumbImage, 0.75);
        weiboMessage.imageObject = imageObject;
    }
    else {
        weiboMessage.text = message.content;
        WBWebpageObject *pageObject = [[WBWebpageObject alloc] init];
        NSString * trimmedStr = [message.urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
            NSRange schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
            if (schemeMarkerRange.location == NSNotFound) {
                pageObject.webpageUrl = [NSString stringWithFormat:@"http://%@",message.urlStr];
            } else {
                pageObject.webpageUrl = message.urlStr;
            }
        }
        else {
            pageObject.webpageUrl = @"http://www.66shouyou.com";
        }
        pageObject.title = message.title;
        pageObject.description = message.content;
        pageObject.objectID = message.messageID;
        if (nil != message.thumbImage) {
            UIImage *thumbImage = message.thumbImage;
            if (thumbImage.size.width > 0 && thumbImage.size.height > 0) {
                if (thumbImage.size.width > 128 || thumbImage.size.height > 128) {
                    CGFloat scale = MAX(128.0 / thumbImage.size.height, 128.0 / thumbImage.size.width);
                    thumbImage = [thumbImage fl_ScaleByFactor:scale];
                }
            }
            pageObject.thumbnailData = UIImageJPEGRepresentation(thumbImage, 0.75);
        }
        
        weiboMessage.mediaObject = pageObject;
    }
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:weiboMessage];
    [WeiboSDK sendRequest:request];
}

+(void)shareWithText:(NSString *)text {
    WBMessageObject *weiboMessage = [WBMessageObject message];
    weiboMessage.text = text;
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:weiboMessage];
    [WeiboSDK sendRequest:request];
}

+(void)handleOpenURL:(NSURL *)url{
    [WeiboSDK handleOpenURL:url delegate:[LLXSocialSharingManager sharedInstance]];
}

+(UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    if (!image) {
        return image;
    }
    if (kb < 1) {
        return image;
    }
    
    kb *= 1024;

    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb", (float)[imageData length]/1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

@end

@implementation LLXSocialSharingManager (WeiboSDK)
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {
        
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        //        NSString *message;
        switch (response.statusCode) {
            case WeiboSDKResponseStatusCodeSuccess:
            {
                //                message = @"发送成功";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidSuccessNotification object:nil];
            }
                break;
            case WeiboSDKResponseStatusCodeUserCancel:
                //                message = @"取消发送";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidCancelNotification object:nil];
                break;
            case WeiboSDKResponseStatusCodeSentFail:
                //                message = @"发送失败";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            case WeiboSDKResponseStatusCodeUserCancelInstall:
                //                message = @"取消安装微博客户端";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            case WeiboSDKResponseStatusCodeUnsupport:
                //                message = @"不支持的请求";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            case WeiboSDKResponseStatusCodeAuthDeny:
                //                message = @"授权失败";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
                
            default:
                //                message = @"未知错误";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
        }
        
        //        [FLProgressHUD showHUDWithTitle:nil msg:message];
    }
}
@end

