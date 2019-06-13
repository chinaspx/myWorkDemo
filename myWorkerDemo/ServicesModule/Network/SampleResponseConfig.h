//
//  SampleResponseConfig.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SampleResponseConfig: NSObject

@property(readonly) NSTimeInterval time;

- (instancetype)initWithTime:(NSTimeInterval)time;

@end
