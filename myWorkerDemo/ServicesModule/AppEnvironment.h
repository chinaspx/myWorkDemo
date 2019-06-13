//
//  AppEnvironment.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Environment.h"

@class RACSignal;
@class User;

/**
 * App运行环境
 */
typedef NS_ENUM(NSInteger) {
    /*调试*/
        AppModeStage = 0,
    /*模拟*/
        AppModeSimulate,
    /*生产*/
        AppModeProduction
} AppMode;

typedef NS_ENUM(NSInteger) {
    UserEventTypeNone,
    UserEventTypeTokenExpired,
    UserEventTypeUpdate,
    UserEventTypeLogout
} UserEventType;

//Language *language
#define PPT [AppEnvironment sharedInstance]
#define CurrentEnv [AppEnvironment sharedInstance].current
///当前语言
#define CurrentEnvLanguage [AppEnvironment sharedInstance].current.language
///当前用户
#define CurrentUser [AppEnvironment sharedInstance].current.user
///当前环境
#define CurrentEnvironmentType [AppEnvironment sharedInstance].appModel

@interface AppEnvironment: NSObject
/**
 * 会话更新
 */
@property(readonly) RACSignal *userCenterUpdate;
/**
 * 环境更新
 */
@property(readonly) RACSignal *appModelUpdate;

/**
 * App当前工作者
 */
@property(readonly) Environment *current;
/**
 * App当前Bundle
 */
@property(readonly) NSBundle *bundle;
/**
 * App当前环境
 */
@property(readonly) AppMode appModel;

+ (AppEnvironment *)sharedInstance;

/**
 * 切换当前运行环境
 * @param mode AppMode
 */
- (void)switchMode:(AppMode)mode;

/**
 * 更新用户
 * @param user User
 */
- (void)updateUser:(id<UserTypeProtocol>)user;

- (void)fromStorage;
@end

@interface AppEnvironment (Default)

- (void)setModulePathProtocol:(id <ModulePathProtocol>)modulePathProtocol;

@end

