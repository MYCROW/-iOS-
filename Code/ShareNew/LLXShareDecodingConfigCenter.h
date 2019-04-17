//  LLXShareDecodingConfigCenter.h

#import <Foundation/Foundation.h>
#import "LLXShareConfigMessage.h"

@interface LLXShareDecodingConfigCenter : NSObject

@property(nonatomic,strong) NSString *configName;

-(instancetype)initWithConfigName:(NSString *)configName;
-(void)updateConfig;
-(NSArray<LLXShareConfigMessage *> *)shareConfigMessages:(LLXShareCondifMessageType)configMessageType;
@end
