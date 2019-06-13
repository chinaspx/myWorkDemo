//
//  Environment.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "Environment.h"
#import "UserTypeProtocol.h"


@implementation Environment

#pragma mark -
#pragma mark - LifeCyle
- (instancetype)initWithUser:(id<UserTypeProtocol>)user api:(HttpClient *)api language:(id<LanguageProtocol>)language {
    self = [super init];
    _user = user;
    _api = api;
    _language = language;
    return self;

}

- (NSDateFormatter *)formatter {
    static NSDateFormatter *INSTANCE = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        INSTANCE = [[NSDateFormatter alloc] init];
    });
    return INSTANCE;
}

@end
