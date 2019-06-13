//
//  PTUpLoadFileResponse.h
//  PPTryst
//
//  Created by 焦梓杰 on 2018/9/7.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTUpLoadFileResponse : NSObject

@property(nonatomic, strong) NSError *SQError;                 // 请求错误信息
@property(nonatomic, strong) NSDictionary *errorDic;           // 请求错误信息data解析

@property(nonatomic, strong) NSArray *resultArray;             // 请求返回数组
@property(nonatomic, strong) id responseObject;                // 返回未知数据
@property(nonatomic, assign) BOOL isCache;                     // 数据是否是缓存
@property(nonatomic, assign) BOOL isSuccess;                   // 请求成功

@property (nonatomic,   copy) NSString *errorCode;             // 错误码
@property (nonatomic,   copy) NSString *errorMsg;              // 错误信息
@property (nonatomic, assign) NSInteger errorType;             // 错误类型
@property (nonatomic, assign) BOOL unLogin;                    // 未登录

+ (instancetype)responseWithObject:(id)responseObject;

@end
