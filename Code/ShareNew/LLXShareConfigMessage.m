//
//  LLXShareConfigMessage.m
//  LLXGame
//
//  Created by MAC0017 on 2019/4/17.
//  Copyright © 2019年 dondong. All rights reserved.
//

#import "LLXShareConfigMessage.h"
#import "FLFileManagerHelp.h"

@implementation LLXShareConfigMessage

- (instancetype)initWithType:(LLXShareCondifMessageType)type
{
    self = [super init];
    if(self) {
        self.type = type;
        
    }
    return self;
}

- (void)setConfigFileFullPath:(NSString *)configFileFullPath
{
    if(_configFileFullPath == configFileFullPath) {
        return;
    }
    _configFileFullPath = configFileFullPath;
    if (NO == [FLFileManagerHelp checkFileInFullPath:configFileFullPath]) {
        return;
    }
    NSString *str = [NSString stringWithContentsOfFile:configFileFullPath encoding:NSUTF8StringEncoding error:nil];
    NSString *strByType = [self getContentByType:str];
    NSArray<NSString *> *strsByGroup = [self getSegmentByGroup:strByType];
    for(NSString *strByGroup in strsByGroup) {
        LLXShareConfigGroup *configGroup = [[LLXShareConfigGroup alloc]initWithConfigString:strByGroup];
        [self.configMessage addObject:configGroup];
    }
}

-(NSString *)getContentByType:(NSString *)string //根据type分割字符串
{
    return nil;
}

-(NSArray<NSString *> *)getSegmentByGroup:(NSString *)string    //根据group分割字符串
{
    return nil;
}

@end

@implementation LLXShareConfigGroup

- (instancetype)initWithConfigString:(NSString *)oneSegmentString
{
    self = [super init];
    if(self) {
        self.index = -1;//定义数据id/业务顺序
        self.oriClassName = @"";
        self.mapClassName = @"";
        self.configGroup = [[NSMutableArray alloc]initWithCapacity:0];
        [self loadConfigFromString:oneSegmentString];
    }
    return self;
}

- (void)loadConfigFromString:(NSString *)oneSegmentString
{
    self.index = -1;//定义数据id/业务顺序
    self.oriClassName = @"";
    self.mapClassName = @"";
    NSArray<NSString *> *strsByCell = [self getCellByRow:oneSegmentString];
    for(NSString *strByCell in strsByCell) {
        LLXShareConfigGroupCell *configGroupCell = [[LLXShareConfigGroupCell alloc]initWithConfigString:strByCell];
        [self.configGroup addObject:configGroupCell];
    }
}

-(NSArray<NSString *> *)getCellByRow:(NSString *)string    //根据行分割字符串
{
    return nil;
}

@end

@implementation LLXShareConfigGroupCell

-(instancetype)initWithConfigString:(NSString *)oneLineString
{
    self = [super init];
    if(self) {
        
    }
    return self;
}

- (void)loadConfigFromString:(NSString *)oneRowString
{
    
}

@end
