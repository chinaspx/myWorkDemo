//
//  RequestProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef RequestProtocol_h
#define RequestProtocol_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpMethod) {
    GET,
    POST
};

@protocol RequestProtocol <NSObject>
/**
 模块ID
 */
@optional
@property(readonly) NSInteger moduleID;
/**
 * 路径
 */
@required
@property(readonly) NSString *path;
/**
 * HttpMethod GET，POST
 */
@required
@property(readonly) HttpMethod method;

/**
 * 参数
 */
@optional
@property(readonly) id parameters;

/**
 响应类型
 */
@required
@property(readonly) Class responseCls;

@end

#endif /* RequestProtocol_h */
