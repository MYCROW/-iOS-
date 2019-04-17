
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
        //[self c]
        return;
    }
    
}

@end

@implementation LLXCategoryHelper
+ (NSArray *)categoryArray
{
    if ([FLFileManagerHelp checkFileInFullPath:KLLCategoryNewModuleKeyCachePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:KLLCategoryNewModuleKeyCachePath];
    }
    return nil;
}
+ (void)deleteCategoryArrayCache
{
    if ([FLFileManagerHelp checkFileInFullPath:KLLCategoryNewModuleKeyCachePath]) {
        BOOL ret = [FLFileManagerHelp deleteFileInFullPath:KLLCategoryNewModuleKeyCachePath];
        if (!ret) {
            NSLog(@"*** delete category Module data failed ***");
        }
    }
}
+ (void)cacheCategoryArray:(NSArray *)categoryArray {
    
    BOOL ret = [NSKeyedArchiver archiveRootObject:categoryArray toFile:KLLCategoryNewModuleKeyCachePath];
    if (!ret) {
        NSLog(@"*** save category Module data failed ***");
    }
}
@end
