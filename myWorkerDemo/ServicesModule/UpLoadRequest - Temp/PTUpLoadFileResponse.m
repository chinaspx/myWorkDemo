//
//  PTUpLoadFileResponse.m
//  PPTryst
//
//  Created by 焦梓杰 on 2018/9/7.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "PTUpLoadFileResponse.h"

@implementation PTUpLoadFileResponse

+(instancetype)responseWithObject:(id)responseObject{
    
    return [[self alloc]initWithData:responseObject];
}

-(instancetype)initWithData:(id)responseObject{
    self = [super init];
    if (self) {
        _responseObject = responseObject;
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            self.isSuccess = [[responseObject objectForKey:@"isSucceed"] boolValue];
            if (!self.isSuccess) {
                self.errorCode = [responseObject objectForKey:@"code"];
                self.errorMsg = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"errorMsg"]];
            }
        }
        
        if ([responseObject isKindOfClass:[NSArray class]]){
            _resultArray = responseObject;
        }else if ([responseObject isKindOfClass:[NSError class]]){
            _SQError = responseObject;
            [self analysisError:_SQError];
        }
        
    }
    return self;
}


/**
 错误解析
 
 @param error 要解析的错误
 */
-(void)analysisError:(NSError*)error{
    
    NSData *data = [NSData dataWithData:[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"]];
    if (data && data.length>0) {
        id errorDescrip = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        
        if ([errorDescrip isKindOfClass:[NSDictionary class]]) {
            _errorDic = errorDescrip;
        }
    }
}

@end
