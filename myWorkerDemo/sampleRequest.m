//
//  sampleRequest.m
//  myWorkerDemo
//
//  Created by chinaspx on 2019/6/13.
//  Copyright © 2019 chinaspx. All rights reserved.
//

#import "sampleRequest.h"
#import "sampleModel.h"


@interface sampleRequest()

@property (nonatomic, copy) NSString *fromUserId;
@property (nonatomic, copy) NSString *toUserId;
@property (nonatomic, copy) NSString *type;

@end

@implementation sampleRequest

#pragma mark -
#pragma mark - RequestProtocol

- (NSString *)path {
    return @"v1/getLabelList.dx";
}

- (HttpMethod)method {
    return POST;
}

- (id)parameters {
    NSDictionary *platformInfo = @{};
    
    NSDictionary *requestDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 platformInfo, @"platformInfo",
                                 self.fromUserId, @"fromUserId",
                                 self.toUserId, @"toUserId",
                                 self.type, @"type",nil];
    
    return requestDict;
}

- (Class)responseCls {
    return [sampleModel class];
}

@end
