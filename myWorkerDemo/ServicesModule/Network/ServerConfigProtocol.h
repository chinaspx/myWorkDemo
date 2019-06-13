//
//  ServerConfigProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef ServerConfigProtocol_h
#define ServerConfigProtocol_h

#import <Foundation/Foundation.h>

@protocol ServerConfigProtocol <NSObject>
@property(readonly) NSString *apiBaseURL;
@property(readonly) NSString *logBaseURL;
@end

#endif /* ServerConfigProtocol_h */
