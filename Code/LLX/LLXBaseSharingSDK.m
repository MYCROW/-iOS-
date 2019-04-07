//
//  LLXBaseSharingSDK.m
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import "LLXBaseSharingSDK.h"

@implementation LLXBaseSharingSDK

+(void)initSDK{}
+(BOOL)isAppInstalled {return NO;}
+(void)shareWithSharingMessage:(LLXSocialSharingBaseMessage *)message{}
+(void)shareWithText:(NSString *)text{}
+(void)handleOpenURL:(NSURL *)url{}
@end
