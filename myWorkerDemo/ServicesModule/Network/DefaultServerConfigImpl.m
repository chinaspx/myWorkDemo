//
//  DefaultServerConfigImpl.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "DefaultServerConfigImpl.h"


@implementation DefaultServerConfigImpl {
    NSString *_apiBaseURL;
    NSString *_logBaseURL;
}

- (instancetype)initWithApiURL:(NSString *)apiBaseURL logBaseURL:(NSString *)logBaseURL {
    self = [super init];
    _apiBaseURL = apiBaseURL;
    _logBaseURL = logBaseURL;
    return self;
}

+ (instancetype)stage {
    return [[DefaultServerConfigImpl alloc] initWithApiURL:[NSString stringWithFormat:@"%@(!PPTryst)",HttpApiName] logBaseURL:@""];
}

+ (instancetype)production {
    return [[DefaultServerConfigImpl alloc] initWithApiURL:[NSString stringWithFormat:@"%@(!PPTryst)",HttpApiName] logBaseURL:@""];
}

- (NSString *)apiBaseURL {
    return _apiBaseURL;
}

- (NSString *)logBaseURL {
    return _logBaseURL;
}

@end
