//
//  LLXShareMainManager.m
//  LLXGame
//
//  Created by MAC0017 on 2019/4/17.
//  Copyright © 2019年 dondong. All rights reserved.
//

#import "LLXShareMainManager.h"
#import "LLXShareDecodingConfigCenter.h"


@implementation LLXShareMainManager

+ (LLXShareMainManager *)sharedInstance {
    static LLXShareMainManager *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[LLXShareMainManager alloc] init];
        }
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
//        [LLXWeiboSharingSDK initSDK];
//        [LLXWechatSharingSDK initSDK];
//        [LLXQQSharingSDK initSDK];
    }
    return self;
}

- (BOOL)shareMessage:(LLXShareStandardMessage *)standardMessage withConfigName:(NSString *)configName
{
    BOOL ret = NO;
    LLXShareDecodingConfigCenter *configCenter = [[LLXShareDecodingConfigCenter alloc]initWithConfigName:configName];
//    LLXShareDefineDataType  = 0,
//    LLXShareDefineRequestType = 1,
//    LLXShareDefineBusinessType = 2,
    NSArray<LLXShareConfigMessage *> *dataConfigMessage= [configCenter shareConfigMessages:LLXShareDefineDataType];
    
    
    
    
    return ret;
}

@end
