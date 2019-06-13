//
//  DefaultServerConfigImpl.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerConfigProtocol.h"


@interface DefaultServerConfigImpl : NSObject <ServerConfigProtocol>
- (instancetype)initWithApiURL:(NSString *)apiBaseURL logBaseURL:(NSString *)logBaseURL;
@end

@interface DefaultServerConfigImpl (AppMode)
+ (instancetype)stage;

+ (instancetype)production;
@end
