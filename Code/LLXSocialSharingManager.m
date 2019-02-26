//
//  LLXSocialSharingManager.m
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXSocialSharingManager.h"
#import "LLXWeiboSharingSDK.h"
#import "LLXWechatSharingSDK.h"
#import "LLXQQSharingSDK.h"
#import "FLHttpRequest.h"

NSString *const kLLSocialSharingDidFinishNotification         = @"kLLSocialSharingDidFinishNotification";
NSString *const kLLXSocialSharingPlatformKey                    = @"platform";
NSString *const kLLXSocialSharingResultKey                    = @"result";

@interface LLXSocialSharingManager ()<QQApiInterfaceDelegate,WXApiDelegate>

@property (nonatomic ,assign)LLXSocialSharingPlatform platform;

@end

@implementation LLXSocialSharingManager

+ (LLXSocialSharingManager *)sharedInstance {
    static LLXSocialSharingManager *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[LLXSocialSharingManager alloc] init];
        }
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socialShareDidSuccess:) name:kBaseSharingDidSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socialShareDidCancel:) name:kBaseSharingDidCancelNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socialShareDidFail:) name:kBaseSharingDidFailNotification object:nil];
        [LLXWeiboSharingSDK initSDK];
        [LLXWechatSharingSDK initSDK];
        [LLXQQSharingSDK initSDK];
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)shareWithMessage:(LLXSocialSharingBaseMessage *)message platform:(LLXSocialSharingPlatform)platform {
    self.platform = platform;
    switch (platform) {
        case LLXSocialSharingPlatform_Weibo:
        {
            //新浪微博
            [LLXWeiboSharingSDK shareWithSharingMessage:message];
        }
            break;
        case LLXSocialSharingPlatform_WeChatSession:
        {
            //微信朋友圈
            [LLXWechatSharingSDK shareWithSharingMessage:message toWhere:XXWechatSharingSceneSession];
        }
            break;
        case LLXSocialSharingPlatform_WeChatTimeline:
        {
            //微信聊天
            [LLXWechatSharingSDK shareWithSharingMessage:message toWhere:XXWechatSharingSceneTimeline];
        }
            break;
        case LLXSocialSharingPlatform_QQ:
        {
            //QQ
            [LLXQQSharingSDK shareWithSharingMessage:message toWhere:LLQQSharingSceneQQ];
        }
            break;
        case LLXSocialSharingPlatform_QQZone:
        {
            //QQ空间
            [LLXQQSharingSDK shareWithSharingMessage:message toWhere:LLQQSharingSceneQQZone];
        }
            break;
        default:
            break;
    }
}

- (void)shareWithText:(NSString *)text platform:(LLXSocialSharingPlatform)platform;
{
    self.platform = platform;
    switch (platform) {
        case LLXSocialSharingPlatform_Weibo:
        {
            //新浪微博
            [LLXWeiboSharingSDK shareWithText:text];
        }
            break;
        case LLXSocialSharingPlatform_WeChatSession:
        {
            //微信朋友圈
            [LLXWechatSharingSDK shareWithText:text toWhere:XXWechatSharingSceneSession];
        }
            break;
        case LLXSocialSharingPlatform_WeChatTimeline:
        {
            //微信聊天
            [LLXWechatSharingSDK shareWithText:text toWhere:XXWechatSharingSceneTimeline];
        }
            break;
        case LLXSocialSharingPlatform_QQ:
        {
            //QQ好友
            [LLXQQSharingSDK shareWithText:text];
        }
            break;
        case LLXSocialSharingPlatform_QQZone:
        {
            //QQ好友
            [LLXQQSharingSDK shareWithText:text toWhere:LLQQSharingSceneQQZone];
        }
            break;
        default:
            break;
    }
}

- (void)socialShareDidSuccess:(NSNotification *)notification {
    NSDictionary *userInfo = @{kLLXSocialSharingPlatformKey:[NSNumber numberWithInteger:self.platform],kLLXSocialSharingResultKey:@(LLXSocialSharingResult_Success)};
    [[NSNotificationCenter defaultCenter] postNotificationName:kLLSocialSharingDidFinishNotification object:nil userInfo:userInfo];
}

- (void)socialShareDidCancel:(NSNotification *)notification {
    NSDictionary *userInfo = @{kLLXSocialSharingPlatformKey:[NSNumber numberWithInteger:self.platform],kLLXSocialSharingResultKey:@(LLXSocialSharingResult_Cancel)};
    [[NSNotificationCenter defaultCenter] postNotificationName:kLLSocialSharingDidFinishNotification object:nil userInfo:userInfo];
}

- (void)socialShareDidFail:(NSNotification *)notification {
    NSDictionary *userInfo = @{kLLXSocialSharingPlatformKey:[NSNumber numberWithInteger:self.platform],kLLXSocialSharingResultKey:@(LLXSocialSharingResult_Fail)};
    [[NSNotificationCenter defaultCenter] postNotificationName:kLLSocialSharingDidFinishNotification object:nil userInfo:userInfo];
}

- (void)handleOpenURL:(NSURL *)url platform:(LLXSocialSharingPlatform)platform {
    switch (platform) {
        case LLXSocialSharingPlatform_Weibo:
        {
            //新浪微博
            [LLXWeiboSharingSDK handleOpenURL:url];
        }
            break;
        case LLXSocialSharingPlatform_WeChatSession:
        {
            //微信朋友圈
            [LLXWechatSharingSDK handleOpenURL:url];
        }
            break;
        case LLXSocialSharingPlatform_WeChatTimeline:
        {
            //微信聊天
            [LLXWechatSharingSDK handleOpenURL:url];
        }
            break;
        case LLXSocialSharingPlatform_QQ:
        {
            //QQ好友
            [LLXQQSharingSDK handleOpenURL:url];
        }
            break;
        case LLXSocialSharingPlatform_QQZone:
        {
            //QQ空间
            [LLXQQSharingSDK handleOpenURL:url];
        }
            break;
        default:
            break;
    }
}

- (void)isOnlineResponse:(NSDictionary *)response {
    
}

- (void)onReq:(QQBaseReq *)req {
    
}

-(void) onResp:(id)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        SendMessageToWXResp *respw = (SendMessageToWXResp*)resp;
        //        NSString *message;
        switch (respw.errCode) {
            case WXErrCodeAuthDeny:
                //                message = @"授权失败";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            case WXErrCodeCommon:
                //                message = @"普通错误";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            case WXErrCodeSentFail:
                //                message = @"发送失败";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            case WXErrCodeUserCancel:
                //                message = @"取消发送";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidCancelNotification object:nil];
                break;
            case WXSuccess:
            {
                //                message = @"发送成功";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidSuccessNotification object:nil];
            }
                break;
            case WXErrCodeUnsupport:
                //                message = @"微信不支持";
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                break;
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                //                message = @"未知错误";
                break;
        }
        //        [FLProgressHUD showHUDWithTitle:nil msg:message];
    }else if ([resp isKindOfClass:[QQBaseResp class]]){
        QQBaseResp *respw = (QQBaseResp*)resp;
        switch (respw.type)
        {
            case ESENDMESSAGETOQQRESPTYPE:
            {
                SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
                if([sendResp.result isEqualToString:@"0"]) {
                    //分享成功
                    [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidSuccessNotification object:nil];
                }else if ([sendResp.result isEqualToString:@"-4"]) {
                    //分享取消
                    [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidCancelNotification object:nil];
                }else{
                    //分享失败
                    [[NSNotificationCenter defaultCenter] postNotificationName:kBaseSharingDidFailNotification object:nil];
                }
                break;
            }
            default:
            {
                break;
            }
        }
    }
}
@end

