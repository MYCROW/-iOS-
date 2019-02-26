//
//  XXSocialSharingMessage.h
//  XXAppStore
//
//  Created by WangMao on 16/8/3.
//  Copyright © 2016年 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLXSocialSharingBaseMessage : NSObject

@property (nonatomic, strong) NSString *messageID;   //用于唯一标识一个多媒体内容(微博分享必填)
@property (nonatomic, strong) NSString *title;       //分享的标题
@property (nonatomic, strong) NSString *content;     //分享的描述内容
@property (nonatomic, strong) NSString *urlStr;      //分享的链接
@property (nonatomic, strong) UIImage  *thumbImage;   //分享的缩略图对象
@property (nonatomic, strong) NSString *thumbImageURL;   //分享的缩略图URL
@property (nonatomic, strong) NSData *imageData;      //分享的图片data

@property (nonatomic, strong) NSDictionary *userInfo;  //透传字段

@end
