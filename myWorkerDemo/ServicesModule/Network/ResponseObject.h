//
//  ResponseObject.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ResponseObject<__covariant T> : NSObject
@property(readonly) NSInteger serverCode;
@property(readonly) NSError *error;
@property(readonly) T data;

- (instancetype)initWithData:(T)data serverCode:(NSInteger)serverCode error:(NSError *)error;

@end
