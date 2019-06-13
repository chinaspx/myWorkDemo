//
//  AppInfo.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

///App的版本类似"2.5.1"
+ (NSString *)appVersion;

///App构建的唯一标识(构建号)
+ (NSInteger )appBuildId;
+ (NSString *)appBuildString;

///App构建的bundleIdentifier
+ (NSString *)bundleIdentifier;

///App当前Agent
+ (NSString *)ULAppUserAgent;

///当前语言
+ (NSString *)currentLanguage;

///是否是主包
+ (BOOL)isMainPacket;

#pragma mark -
#pragma mark -CustomKey
///-获取定制Key
- (NSString *)getCustomKey:(NSString *)key;
///+获取定制Key
+ (NSString *)getCustomKey:(NSString *)key;

@end
