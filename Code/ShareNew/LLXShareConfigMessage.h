//
//  LLXShareConfigMessage.h
//  LLXGame
//
//  Created by MAC0017 on 2019/4/17.
//  Copyright © 2019年 dondong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LLXShareCondifMessageType) {
    LLXShareDefineDataType  = 0,
    LLXShareDefineRequestType = 1,
    LLXShareDefineBusinessType = 2,
};

typedef NS_ENUM(NSUInteger, LLXShareMapType) {
    LLXShareMapStaticMethodType  = 0,
    LLXShareMapObjectMethodType = 1,
    LLXShareMapPropertyType = 2,
};

@class LLXShareConfigGroup;
@class LLXShareConfigGroupCell;

@interface LLXShareConfigMessage : NSObject //定义一种类型的映射关系

@property(nonatomic,assign)LLXShareCondifMessageType type;
@property(nonatomic,strong)NSMutableArray<LLXShareConfigGroup *> *configMessage;

- (instancetype)initWithType:(LLXShareCondifMessageType)type;

@end

@interface LLXShareConfigGroup : NSObject //定义一个类对另一个类的映射关系

@property(nonatomic,assign)UInt32 index;//定义数据id/业务顺序
@property(nonatomic,strong)NSString *oriClassName;
@property(nonatomic,strong)NSString *mapClassName;
@property(nonatomic,strong)NSMutableArray<LLXShareConfigGroupCell *> *configGroup;

@end

@interface LLXShareConfigGroupCell : NSObject //定义一条映射关系

@property(nonatomic,strong)NSString *inputValueClassName;
@property(nonatomic,strong)NSString *inputValueName;
@property(nonatomic,assign)LLXShareMapType mapType;//映射类型0:静态方法 1:实例方法 2:属性赋值
//0:静态方法 1:实例方法
@property(nonatomic,strong)NSString *mapMethodReturnValueClassName;//对应方法返回类型
@property(nonatomic,strong)NSString *mapMethodName;//对应方法名
@property(nonatomic,strong)NSString *mapMethodArugmentIndex;//对应参数位置
//1:实例方法
@property(nonatomic,strong)id object;//实例方法的实例对象
//2:属性赋值
@property(nonatomic,strong)NSString *mapValueClassName;//对应属性变量类名
@property(nonatomic,strong)NSString *mapValueName;//对应属性变量名

-(instancetype)initWithConfigString:(NSString *)oneLineString;

@end
