//
//  SimulatorResponseTypeProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef SimulatorResponseTypeProtocol_h
#define SimulatorResponseTypeProtocol_h

#import <Foundation/Foundation.h>

@protocol SimulatorResponseTypeProtocol <NSObject>
@optional
- (NSTimeInterval)delay;

- (id)sampleData;
@end

#endif /* SimulatorResponseTypeProtocol_h */
