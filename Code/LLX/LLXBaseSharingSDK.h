//
//  LLXBaseSharingSDK.h
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLXSocialSharingBaseMessage.h"
#import "LLXSocialSharingSDKDefine.h"

@interface LLXBaseSharingSDK : NSObject

+(void)initSDK;
+(BOOL)isAppInstalled;
+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message;
+(void)shareWithText:(NSString *)text;
+(void)handleOpenURL:(NSURL *)url;

@end
