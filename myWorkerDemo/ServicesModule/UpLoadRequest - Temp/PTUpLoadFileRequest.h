//
//  PTUpLoadFileRequest.h
//  PPTryst
//
//  Created by 焦梓杰 on 2018/9/7.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "PTUpLoadFileResponse.h"

/**
 请求代理
 */
@class PTUpLoadFileRequest;
@protocol PTUpLoadFileRequestDelegate <NSObject>

@optional
- (void)apiRequestSuccessed:(PTUpLoadFileRequest *)request;
- (void)apiRequestFailed:(PTUpLoadFileRequest *)request;
- (void)apiRequestUploadProgress:(PTUpLoadFileRequest *)request;

@end

typedef void(^PTApiSuccessBlock) (PTUpLoadFileResponse *response);     //成功的回调
typedef void(^PTApiFailureBlock) (NSError *error);              //失败回调
typedef void(^PTApiProgressBlock) (NSProgress *uploadProgress); //请求进度
typedef void(^SQDownLoadCompleteBlock) (NSURL *filePath, NSError *error);   //下载任务回调

@interface PTUpLoadFileRequest : NSObject

@property (nonatomic, readonly) AFHTTPSessionManager *sessionManager;
@property (nonatomic, readonly) NSURLSessionDataTask *task;       //正在执行的任务
@property (nonatomic, strong) NSError *error;                        //请求失败错误信息
@property (nonatomic, strong) NSProgress *uploadProgress;            //上传进度信息
@property (nonatomic, strong) PTUpLoadFileResponse *response;               //请求返回数据对象

@property (nonatomic,   weak) id<PTUpLoadFileRequestDelegate> delegate;
@property (nonatomic,   copy) NSString *requestMethod;      //POST、GET、PUT、DELETE    默认是POST
@property (nonatomic,   copy) NSString *url;    //请求url
@property (nonatomic,   copy) NSDictionary *param;          //传递的JSON 参数

@property (nonatomic, copy) PTApiSuccessBlock successBlock; //成功回调
@property (nonatomic, copy) PTApiFailureBlock failureBlock; //失败回调
@property (nonatomic, copy) PTApiProgressBlock progressBlock; //下载进度回调

+(instancetype)requestWithUrl:(NSString *)url param:(NSString *)param;

///上传 - 图片文件
- (void)startUploadWithPhotoArray:(NSArray *)photoArray;
- (void)startUploadWithPhotoArray:(NSArray *)photoArray progress:(PTApiProgressBlock)progress success:(PTApiSuccessBlock)success failure:(PTApiFailureBlock)failure;

///上传 - 音频文件
- (void)startUploadWithVoiceFilePath:(NSString *)filePath;
- (void)startUploadWithVoiceFilePath:(NSString *)filePath progress:(PTApiProgressBlock)progress success:(PTApiSuccessBlock)success failure:(PTApiFailureBlock)failure;

@end
