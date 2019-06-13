//
//  HttpClient.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "HttpClient.h"
#import "SimulatorResponseTypeProtocol.h"
#import "ModulePathProtocol.h"
#import "TransformTypeProtocol.h"

#import "Language.h"
#import "AppInfo.h"

@implementation HttpClient {
    NSMutableArray <id <Injector>> *_injectors;
    AFHTTPSessionManager *_manager;
    NSString *_baseURLString;
//    dispatch_queue_t _stubQueue;
    SimulatorType _simulatorType;
    id <ModulePathProtocol> _modulePathProtocol;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"please use initWithBaseURLString:baseURLString or initWithSession:session baseURLString:baseURLString instead" reason:@"not support" userInfo:nil];
    return nil;
}

+ (instancetype)new {
    @throw [NSException exceptionWithName:@"please use initWithBaseURLString:baseURLString or initWithSession:session baseURLString:baseURLString instead" reason:@"not support" userInfo:nil];
    return nil;
}

- (instancetype)initWithBaseURLString:(NSString *)baseURLString {
    return [self initWithBaseURLString:baseURLString simulatorType:SimulatorTypeNone modulePathProtocol:nil];
}

- (instancetype)initWithBaseURLString:(NSString *)baseURLString simulatorType:(SimulatorType)type {
    return [self initWithBaseURLString:baseURLString simulatorType:type modulePathProtocol:nil];
}

- (instancetype)initWithBaseURLString:(NSString *)baseURLString simulatorType:(SimulatorType)type modulePathProtocol:(id <ModulePathProtocol>)modulePathProtocol {
    self = [super init];
    _baseURLString = baseURLString;
    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [_manager.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"Charset"];
    [_manager.requestSerializer setValue:[Language getCurrentAPPLanguageAndRegion] forHTTPHeaderField:@"Accept-Language"];
    [_manager.requestSerializer setValue:[AppInfo ULAppUserAgent] forHTTPHeaderField:@"UserAgent"];
    _injectors = [NSMutableArray array];
//    _stubQueue = dispatch_queue_create("com.onlyux.networking.stub", NULL);
    _simulatorType = type;
    _modulePathProtocol = modulePathProtocol;
    return self;
}


- (void)addInjector:(id <Injector>)injector {
    [_injectors addObject:injector];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (RACSignal *)request:(id <RequestProtocol>)request {
    if ([request conformsToProtocol:@protocol(SimulatorResponseTypeProtocol)] && _simulatorType == SimulatorTypeUsing) {
        id <SimulatorResponseTypeProtocol> simulatorType = (id <SimulatorResponseTypeProtocol>) request;
        NSTimeInterval time = [simulatorType respondsToSelector:@selector(delay)] ? simulatorType.delay : 0;
        return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            [subscriber sendNext:[[ResponseObject alloc] initWithData:simulatorType.sampleData serverCode:0 error:nil]];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{

            }];
        }] delay:time];
    } else {
        //检测路径
        NSString *path = request.path;
        if ([request respondsToSelector:@selector(moduleID)] && _modulePathProtocol) {
            id <ModulePathProtocol> module = (id <ModulePathProtocol>) request;
            if ([module respondsToSelector:@selector(moduleID)]) {
                path = [NSString stringWithFormat:@"%@/%@", [_modulePathProtocol modulePath:request.moduleID], request.path];
            }
        }
        
        //检测自定义header-后续根据需求处理
        
        //开始请求
        void (^block)(id <RACSubscriber>, id, NSInteger, NSError *) = ^(id <RACSubscriber> a, id b, NSInteger c, NSError *d) {
            [a sendNext:[[ResponseObject alloc] initWithData:b serverCode:c error:d]];
        };
        NBLog(@"path:%@", path);
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            NSURLSessionDataTask *task = [self->_manager dataTaskWithRequest:[self reqeust:path params:request.parameters rq:request]
                                                              uploadProgress:nil
                                                            downloadProgress:nil
                                                           completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject, NSError *_Nullable error) {
                                                               if (error) {
                                                                   block(subscriber, nil, 0, error);
                                                               } else {
                                                                   if (responseObject) {
                                                                       id rlt = (id) [request.responseCls performSelector:@selector(yy_modelWithDictionary:) withObject:responseObject withObject:nil];
                                                                       NBLog(@"responseObject --->>>:%@", responseObject);
                                                                       if (responseObject[@"errorCode"]) {
                                                                           NBLog(@"responseObject errorCode--->>>:%@", responseObject[@"errorCode"]);
                                                                       }
                                                                       if (responseObject[@"errorMsg"]) {
                                                                           NBLog(@"responseObject errorMsg--->>>:%@", responseObject[@"errorMsg"]);
                                                                       }
                                                                       
                                                                       if ([request conformsToProtocol:@protocol(TransformTypeProtocol)]) {
                                                                           block(subscriber, [(id<TransformTypeProtocol>)request transform:rlt], 0, nil);
                                                                       } else {
                                                                           block(subscriber, rlt, 0, nil);
                                                                       }
                                                                   } else {
                                                                       block(subscriber, nil, 0, nil);
                                                                   }
                                                               }
                                                           }];
            [task resume];
            return [RACDisposable disposableWithBlock:^{
                [task cancel];
            }];
        }];
    }
}

#pragma clang diagnostic pop

- (NSURLRequest *)reqeust:(NSString *)path params:(NSData *)params rq:(id <RequestProtocol>)rq {
    NSError *serializationError = nil;
    NSMutableURLRequest *request = nil;

    NSString *methodString = @"POST";
    switch (rq.method) {
        case POST: {
            methodString = @"POST";
            NBLog(@"fullPath:%@", [NSString stringWithFormat:@"%@%@", _manager.baseURL.absoluteString, path]);
            NBLog(@"params:%@", params);
            NBLog(@"params json:%@", [params mj_JSONString]);
            request = [_manager.requestSerializer requestWithMethod:methodString URLString:[NSString stringWithFormat:@"%@%@", _manager.baseURL.absoluteString, path] parameters:params error:&serializationError];
        }
            break;
        case GET: {
            methodString = @"GET";
            request = [_manager.requestSerializer requestWithMethod:methodString URLString:[NSString stringWithFormat:@"%@%@", _manager.baseURL.absoluteString, path] parameters:params error:&serializationError];
        }
            break;
    }
    
    if (serializationError) {
        return nil;
    }
    
//    if (parameters) {
//        if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
//            [mutableRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        }
//
//        if (![NSJSONSerialization isValidJSONObject:parameters]) {
//            if (error) {
//                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(@"The `parameters` argument is not valid JSON.", @"AFNetworking", nil)};
//                *error = [[NSError alloc] initWithDomain:AFURLRequestSerializationErrorDomain code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
//            }
//            return nil;
//        }
//
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:self.writingOptions error:error];
    
//        if (!jsonData) {
//            return nil;
//        }
//
//        [mutableRequest setHTTPBody:jsonData];
//    }

    return request;
}

- (void)forInjector:(NSURLResponse *)response data:(NSData *)data {
    [_injectors enumerateObjectsUsingBlock:^(id <Injector> obj, NSUInteger idx, BOOL *stop) {
        [obj after:response data:data];
    }];
}

- (NSString *)debugDescription {
    return self.description;
}

@end
