//
//  ModulePathProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef ModulePathProtocol_h
#define ModulePathProtocol_h

#import <Foundation/Foundation.h>

@protocol ModulePathProtocol <NSObject>
@optional
- (NSString *)modulePath:(NSInteger)moduleID;
@end

#endif /* ModulePathProtocol_h */
