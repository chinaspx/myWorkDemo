//
//  HttpClient.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestProtocol.h"
#import "ResponseObject.h"
#import "RACSignal.h"

@class SampleResponseConfig;
@class ResponseObject;
@protocol ModulePathProtocol;

typedef NS_ENUM(NSInteger, SimulatorType) {
    SimulatorTypeNone,
    SimulatorTypeUsing
};

@protocol Injector
- (void)after:(NSURLResponse *)response data:(NSData *)data;
@end

@interface HttpClient : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 * 构造默认Client Session使用的是NSURLSession.shareSession
 * @param baseURLString NSString
 * @return HttpClient
 */
- (instancetype)initWithBaseURLString:(NSString *)baseURLString;

- (instancetype)initWithBaseURLString:(NSString *)baseURLString simulatorType:(SimulatorType)type;

- (instancetype)initWithBaseURLString:(NSString *)baseURLString simulatorType:(SimulatorType)type modulePathProtocol:(id <ModulePathProtocol>)modulePathProtocol;

- (void)addInjector:(id <Injector>)injector;

- (RACSignal<ResponseObject *> *)request:(id <RequestProtocol>)request;
@end
