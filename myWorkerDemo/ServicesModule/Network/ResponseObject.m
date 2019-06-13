//
//  ResponseObject.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "ResponseObject.h"


@implementation ResponseObject {

}
- (instancetype)initWithData:(id)data serverCode:(NSInteger)serverCode error:(NSError *)error {
    self = [super init];
    _data = data;
    _serverCode = serverCode;
    _error = error;
    return self;
}

@end
