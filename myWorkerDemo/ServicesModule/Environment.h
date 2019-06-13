//
//  Environment.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
#import "Language.h"

@protocol UserTypeProtocol;
@interface Environment: NSObject

@property(nonatomic, strong) id<UserTypeProtocol> user;
@property(readonly) HttpClient *api;
@property(readonly) id<LanguageProtocol> language;
@property(readonly) NSDateFormatter *formatter;

- (instancetype)initWithUser:(id<UserTypeProtocol>)user
                         api:(HttpClient *)api
                    language:(id<LanguageProtocol>)language;
@end
