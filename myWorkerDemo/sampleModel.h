//
//  sampleModel.h
//  myWorkerDemo
//
//  Created by chinaspx on 2019/6/13.
//  Copyright © 2019 chinaspx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface sampleModel : NSObject

@property (nonatomic, copy) NSString *fromUserId;
@property (nonatomic, copy) NSString *toUserId;
@property (nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
