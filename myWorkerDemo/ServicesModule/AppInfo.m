//
//  AppInfo.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "AppInfo.h"
#import "AppEnvironment.h"
#import <SDVersion/SDVersion.h>
#import <UIKit/UIKit.h>
#import "UserTypeProtocol.h"

@implementation AppInfo

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSInteger)appBuildId {
    return [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] integerValue];
}

+ (NSString *)appBuildString {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)bundleIdentifier {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    return bundleIdentifier;
}

+ (NSString *)ULAppUserAgent {
    //https://wiki.pengpengla.com/pages/viewpage.action?pageId=7512889
    static NSString *s_userAgentString = nil;
    if (!s_userAgentString) {
        NSString *appVersionStr = [self appVersion];
        NSString *systemVersionString = [[UIDevice currentDevice] systemVersion];
        NSString *deviceString = [[SDiOSVersion deviceNameString] stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *buildStr = [self appBuildString];
        NSString *deviceId = @"";//[AIShuMeiManager shuMeiDeviceId];

        s_userAgentString
            = [NSString stringWithFormat:@"iOS/appstore version/%@ os/%@ model/%@ build/%@ smd/%@", appVersionStr, systemVersionString, deviceString, buildStr, deviceId];
    }
    return s_userAgentString;
}

+ (NSString *)currentLanguage {
    return @"";
}

///是否是主包
+ (BOOL)isMainPacket {
    NSString *bundleID = [self bundleIdentifier];
    if ([bundleID isEqualToString:kAPPMainProductBundleID]) {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark -CustomKey
- (NSString *)getCustomKey:(NSString *)key {
    return [[self class] getCustomKey:key];
}

+ (NSString *)getCustomKey:(NSString *)key {
    if (key.length <= 0) {
        key = @"";
    }
    NSString *identifier = [self bundleIdentifier];
    NSString *userId = [NSString stringWithFormat:@"%ld", (long) AppEnvironment.sharedInstance.current.user.uid];

    NSString *string = [NSString stringWithFormat:@"%@_%@_%@", identifier, userId, key];
    return string;
}
@end
