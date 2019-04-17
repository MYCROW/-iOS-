
#import "LLXShareDecodingConfigCenter.h"
#import "FLFileManagerHelp.h"

#define kLLXShareConfigFilePath kLLDocumentDir

@interface LLXShareDecodingConfigCenter ()
@property(nonatomic,strong) NSMutableArray<LLXShareConfigMessage *> *shareConfigMessages;
@end

@implementation LLXShareDecodingConfigCenter

-(instancetype)initWithConfigName:(NSString *)configName
{
    self = [super init];
    if(self){
        self.configName = configName;
        self.shareConfigMessages = [[NSMutableArray alloc]initWithCapacity:0];
        [self loadConfigfile];
    }
    return self;
}

- (void)updateConfig
{
    self.shareConfigMessages = [[NSMutableArray alloc]initWithCapacity:0];
//    postNotification
}

- (NSArray<LLXShareConfigMessage *> *)shareConfigMessages:(LLXShareCondifMessageType)configMessageType
{
    NSMutableArray<LLXShareConfigMessage *> *shareConfigMessage = [[NSMutableArray alloc]initWithCapacity:0];
    for(LLXShareConfigMessage *oneMessage in self.shareConfigMessages){
        if(oneMessage.type == configMessageType) {
            [shareConfigMessage addObject:oneMessage];
        }
    }
    return shareConfigMessage;
}

- (void)loadConfigfile
{
    NSString *configFileFullPath = [kLLXShareConfigFilePath stringByAppendingPathComponent:self.configName];
    if (NO == [FLFileManagerHelp checkFileInFullPath:configFileFullPath]) {
        return;
    }
    //改成遍历枚举？
    LLXShareConfigMessage *shareConfigMessage = [[LLXShareConfigMessage alloc]initWithType:LLXShareDefineDataType];
    shareConfigMessage.configFileFullPath = configFileFullPath;
    [self.shareConfigMessages addObject:shareConfigMessage];
    shareConfigMessage = [[LLXShareConfigMessage alloc]initWithType:LLXShareDefineRequestType];
    shareConfigMessage.configFileFullPath = configFileFullPath;
    [self.shareConfigMessages addObject:shareConfigMessage];
    shareConfigMessage = [[LLXShareConfigMessage alloc]initWithType:LLXShareDefineBusinessType];
    shareConfigMessage.configFileFullPath = configFileFullPath;
    [self.shareConfigMessages addObject:shareConfigMessage];
}

@end
