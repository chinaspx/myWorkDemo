//
//  JSONRequestSerialization.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "JSONRequestSerialization.h"


@implementation JSONRequestSerialization {

}

- (NSURLRequest *)request:(NSURLRequest *)request
                   params:(id)params
                    error:(NSError **)error {
    NSMutableURLRequest *mutableURLRequest = [request mutableCopy];

    [mutableURLRequest setValue:@"application/json" forHTTPHeaderField:@"Content-type"];


    return mutableURLRequest;
}

@end
