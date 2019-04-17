//
//  LLXShareMainManager.h
//  LLXGame
//
//  Created by MAC0017 on 2019/4/17.
//  Copyright © 2019年 dondong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLXShareStandardMessage.h"

@interface LLXShareMainManager : NSObject

+ (LLXShareMainManager *)sharedInstance;
- (BOOL)shareMessage:(LLXShareStandardMessage *)standardMessage withConfigName:(NSString *)configName;

//- (void)handleOpenURL:(NSURL *)url platform:(LLXSocialSharingPlatform)platform;
@end

