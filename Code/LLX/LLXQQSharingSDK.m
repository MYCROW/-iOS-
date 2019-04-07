//
//  LLXQQSharingSDK.m
//  XXAppStore
//
//  Created by WangMao on 16/8/7.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXQQSharingSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "FLProgressHUD.h"
#import "LLXSocialSharingManager.h"
#import "FLAlertView.h"

#define kTencentAppID  @"1106261465"
#define kTencentAppKey @"npJW9HJJOZPozZjh"

@interface LLXSocialSharingManager (QQSDK)
<
TencentSessionDelegate,
QQApiInterfaceDelegate
>
@property(nonatomic, strong)TencentOAuth *tencentOAuth;

- (void)doQQLogin;

@end

@implementation LLXQQSharingSDK

+(void)initSDK{
//    [[self class] doQQLogin];

}
+(BOOL)isAppInstalled {
    BOOL isAppInstalled = [QQApiInterface isQQInstalled];
    if (!isAppInstalled) {
        [FLProgressHUD showFailWithTitle:nil msg:NSLocalizedString(@"您还没有安装QQ，请先安装", nil)];
    }
    return isAppInstalled;
}

+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message{
    [self shareWithSharingMessage:message toWhere:LLQQSharingSceneQQ];
}

+(void)shareWithText:(NSString *)text{
    [self shareWithText:text toWhere:LLQQSharingSceneQQ];
}


+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message toWhere:(LLQQSharingScene)where {
 
    if (![[self class] isAppInstalled]) {
        return;
    }
    [[LLXSocialSharingManager sharedInstance] doQQLogin];
    QQApiSendResultCode sent = EQQAPISENDSUCESS;

    if(where == LLQQSharingSceneQQ){
        if (message.imageData) {
            QQApiImageObject *imgObj = [QQApiImageObject objectWithData:message.imageData
                                                       previewImageData:UIImagePNGRepresentation(message.thumbImage)
                                                                  title:message.title
                                                            description:message.content];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
            sent = [QQApiInterface sendReq:req];
        } else if (message.thumbImageURL.length > 0) {
            QQApiURLObject *urlObj = [QQApiURLObject objectWithURL:[NSURL URLWithString:message.urlStr]
                                                             title:message.title
                                                       description:message.content
                                                   previewImageURL:[NSURL URLWithString:message.thumbImageURL]
                                                 targetContentType:QQApiURLTargetTypeNews];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:urlObj];
            sent = [QQApiInterface sendReq:req];
        } else {
            QQApiURLObject *urlObj = [QQApiURLObject objectWithURL:[NSURL URLWithString:message.urlStr]
                                                             title:message.title
                                                       description:message.content
                                                  previewImageData:UIImagePNGRepresentation(message.thumbImage)
                                                 targetContentType:QQApiURLTargetTypeNews];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:urlObj];
            sent = [QQApiInterface sendReq:req];
        }
    }
    else if(where == LLQQSharingSceneQQZone){
        NSArray *imageArray;
        if (message.imageData) {
            imageArray = @[message.imageData];
            QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:imageArray title:message.content];
            obj.title = message.title;
            obj.description = message.content;
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
            sent = [QQApiInterface SendReqToQZone:req];
        } else if (message.thumbImageURL.length > 0) {
            QQApiNewsObject *urlObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:message.urlStr]
                                                               title:message.title
                                                         description:message.content
                                                    previewImageURL:[NSURL URLWithString:message.thumbImageURL]
                                                   targetContentType:QQApiURLTargetTypeNews];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObj];
            sent = [QQApiInterface SendReqToQZone:req];
        } else {
            QQApiNewsObject *urlObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:message.urlStr]
                                                               title:message.title
                                                         description:message.content
                                                     previewImageData:UIImagePNGRepresentation(message.thumbImage)];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:urlObj];
            sent = [QQApiInterface SendReqToQZone:req];
        }
    }
    [self handleSendResult:sent];
 
}

+(void)shareWithText:(NSString *)text toWhere:(LLQQSharingScene)where {
 
    if (![[self class] isAppInstalled]) {
        return;
    }
    [[LLXSocialSharingManager sharedInstance] doQQLogin];
    QQApiSendResultCode sent = EQQAPISENDSUCESS;
    if(where == LLQQSharingSceneQQ){
        QQApiTextObject* txtObj = [QQApiTextObject objectWithText:text];
        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:txtObj];
        sent = [QQApiInterface sendReq:req];
    }
    else if(where == LLQQSharingSceneQQZone){
        QQApiImageArrayForQZoneObject *obj = [QQApiImageArrayForQZoneObject objectWithimageDataArray:nil title:text];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
        sent = [QQApiInterface SendReqToQZone:req];
    }
    [self handleSendResult:sent];
 
}


+(void)sentToQQWPAWithQQNumber:(NSString *)qqNumber {
    
    if (NO == [QQApiInterface isQQInstalled]) {
        FLAlertView *alertView = [[FLAlertView alloc] initWithTitle:@"提示"
                                                            message:[NSString stringWithFormat:@"嗨，朋友，需要您手动添加客服QQ：%@沟通。\nPS：未安装QQ或QQ版本太低，无法直接聊天", qqNumber]
                                                           delegate:nil
                                                  cancelButtonTitle:@"关闭"
                                                  otherButtonTitles:@"复制", nil];
        alertView.didDismissBlock = ^(FLAlertView *view, NSInteger buttonIndex) {
            if ([view cancelButtonIndex] != buttonIndex) {
                [UIPasteboard generalPasteboard].string = qqNumber;
                [FLProgressHUD showHUDWithMsg:@"已复制到粘贴板"];
            }
        };
        [alertView show];
        return;
    }

    [[LLXSocialSharingManager sharedInstance] doQQLogin];
    QQApiWPAObject *wpaObj = [QQApiWPAObject objectWithUin:qqNumber];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:wpaObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
 
}

+ (void)sentToJoinGrouWithQQGroup:(NSString *)qqGroup
{
    if (NO == [QQApiInterface isQQInstalled]) {
        FLAlertView *alertView = [[FLAlertView alloc] initWithTitle:@"提示"
                                                            message:[NSString stringWithFormat:@"嗨，朋友，需要您手动添加QQ群：%@沟通。\nPS：未安装QQ或QQ版本太低，无法直接进群", qqGroup]
                                                           delegate:nil
                                                  cancelButtonTitle:@"关闭"
                                                  otherButtonTitles:@"复制", nil];
        alertView.didDismissBlock = ^(FLAlertView *view, NSInteger buttonIndex) {
            if ([view cancelButtonIndex] != buttonIndex) {
                [UIPasteboard generalPasteboard].string = qqGroup;
                [FLProgressHUD showHUDWithMsg:@"已复制到粘贴板"];
            }
        };
        [alertView show];
        return;
    }
    
    [[LLXSocialSharingManager sharedInstance] doQQLogin];
    QQApiJoinGroupObject *joinObj = [QQApiJoinGroupObject objectWithGroupInfo:qqGroup key:@""];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:joinObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

+(void)handleOpenURL:(NSURL *)url{

    [QQApiInterface handleOpenURL:url delegate:[LLXSocialSharingManager sharedInstance]];
}

+ (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPISENDSUCESS:
            break;
        case EQQAPIVERSIONNEEDUPDATE:
            [FLProgressHUD showFailWithTitle:nil msg:NSLocalizedString(@"当前QQ版本太低，需要更新", nil)];
            break;
        case EQQAPIAPPNOTREGISTED:
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        case EQQAPIQQNOTINSTALLED:
        case EQQAPIQQNOTSUPPORTAPI:
        case EQQAPISENDFAILD:
        case EQQAPIQZONENOTSUPPORTTEXT:
        case EQQAPIQZONENOTSUPPORTIMAGE:
            [FLProgressHUD showFailWithTitle:nil msg:NSLocalizedString(@"发送失败", nil)];
            break;
        default:
        {
            break;
        }
    }
}
 

@end

@implementation LLXSocialSharingManager (QQSDK)

- (void)doQQLogin {
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
    self.tencentOAuth = tencentOAuth;
}

- (TencentOAuth *)tencentOAuth {
    return nil;
}

- (void)setTencentOAuth:(TencentOAuth *)tencentOAuth {
    
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp{

}
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin {
    
}

/**
 * 登录失败后的回调
 * param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
    
}


/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
    
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    
}

@end
