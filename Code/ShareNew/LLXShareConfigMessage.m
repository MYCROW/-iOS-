//
//  LLXShareConfigMessage.m
//  LLXGame
//
//  Created by MAC0017 on 2019/4/17.
//  Copyright © 2019年 dondong. All rights reserved.
//

#import "LLXShareConfigMessage.h"

@implementation LLXShareConfigMessage

- (instancetype)initWithType:(LLXShareCondifMessageType)type
{
    self = [super init];
    if(self) {
        self.type = type;
        
    }
    return self;
}

@end
