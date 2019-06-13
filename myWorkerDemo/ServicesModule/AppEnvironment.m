//
//  AppEnvironment.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <pthread.h>
#import "AppEnvironment.h"
#import <RACSubject.h>
#import "DefaultServerConfigImpl.h"
#import "ModulePathProtocol.h"
#import "UserTypeProtocol.h"

static pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;

typedef struct {
    AppMode mode;
} AppCurrentStatus;

static AppCurrentStatus status = {AppModeStage};

@interface AppEnvironment (Private)

- (Environment *)defaultEnv;

@end

@implementation AppEnvironment {
    RACSubject *_userCenterUpdateSubject;//用户中心
    RACSubject *_appModelUpdateSubject;
    NSMutableArray<Environment *> *_stack;
    
    id <ModulePathProtocol> _modulePathProtocol;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
        _userCenterUpdateSubject = [RACSubject subject];
        _appModelUpdateSubject = [RACSubject subject];
        
        //初始化时先放入一个默认环境配置
        [_stack addObject:[self defaultEnv]];
    }
    return self;
}

+ (AppEnvironment *)sharedInstance {
    static AppEnvironment *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppEnvironment alloc] init];
    });
    return instance;
}

- (RACSignal *)userCenterUpdate {
    return _userCenterUpdateSubject;
}

- (RACSignal *)appModelUpdate {
    return _appModelUpdateSubject;
}

- (void)switchMode:(AppMode)mode {
    status.mode = mode;
    Environment *env = [[Environment alloc] initWithUser:self.current.user
                                                     api:[[HttpClient alloc] initWithBaseURLString:@""]
                                                language:self.current.language];
    [self _replaceEnv:env];
    [_appModelUpdateSubject sendNext:@(mode)];
}

- (Environment *)current {
    pthread_rwlock_rdlock(&lock);
    Environment *env = _stack.lastObject;
    pthread_rwlock_unlock(&lock);
    return env;
}

- (void)updateUser:(id<UserTypeProtocol>)user {
    Environment *env = [[Environment alloc] initWithUser:user
                                                     api:self.current.api
                                                language:self.current.language];
    [self _replaceEnv:env];
    [_userCenterUpdateSubject sendNext:@(user && user.uid > 0 ? UserEventTypeUpdate : UserEventTypeLogout)];
}

- (void)fromStorage {

}

- (void)_replaceEnv:(Environment *)env {
    pthread_rwlock_wrlock(&lock);
    [_stack replaceObjectAtIndex:0 withObject:env];
    pthread_rwlock_unlock(&lock);
}

- (AppMode)appModel {
    return status.mode;
}

@end

@implementation AppEnvironment (Private)
- (void)setModulePathProtocol:(id <ModulePathProtocol>)modulePathProtocol {
    _modulePathProtocol = modulePathProtocol;
    //更新一下环境
    [self _replaceEnv:[self defaultEnv]];
}

- (Environment *)defaultEnv {
    id<ServerConfigProtocol> config = nil;
    switch (status.mode) {
        case AppModeStage:
            config = DefaultServerConfigImpl.stage;
            break;

        case AppModeProduction:
            config = DefaultServerConfigImpl.production;
            break;
        default:break;
    }
//    return [[Environment alloc] initWithUser:nil
//                                         api:[[HttpClient alloc] initWithBaseURLString:config.apiBaseURL simulatorType:SimulatorTypeUsing modulePathProtocol:_modulePathProtocol]
//                                    language:[[Language alloc] initWithLanguage:@"zh-Hans"]];
    //获取当前设备语言
    [Language saveCurrentSystemLanguage];
    NBLog(@"NSUserDefaults standardUserDefaults objectForKey:kUserDefaultAppLanguage:%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"PPTrystAppLanguage"]);
    NBLog(@"[Language getCurrentAPPLanguageAndRegion]:%@", [Language getCurrentAPPLanguageAndRegion]);
    
    return [[Environment alloc] initWithUser:nil
                                         api:[[HttpClient alloc] initWithBaseURLString:config.apiBaseURL simulatorType:SimulatorTypeUsing modulePathProtocol:_modulePathProtocol]
                                    language:[[Language alloc] initWithLanguage:[Language getCurrentAPPLanguageAndRegion]]];
}

@end
