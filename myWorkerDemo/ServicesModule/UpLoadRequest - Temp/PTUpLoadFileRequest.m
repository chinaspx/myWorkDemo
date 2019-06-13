//
//  PTUpLoadFileRequest.m
//  PPTryst
//
//  Created by 焦梓杰 on 2018/9/7.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "PTUpLoadFileRequest.h"

@implementation PTUpLoadFileRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/html",@"text/json",@"text/xml",@"multipart/form-data",nil];
        _requestMethod = @"POST";  // 默认post请求
    }
    return self;
}

+ (instancetype)request {
    return [[self alloc]init];
}

+ (instancetype)requestWithUrl:(NSString *)url param:(NSString *)param {
    PTUpLoadFileRequest *request = [self request];
    request.url = [NSString stringWithFormat:@"%@(!PPTryst)/%@?%@%@",HttpApiName,url,[PTUtils requestBaseHeader],StringIsNullToEmpty(param)];
    return request;
}

- (void)startUploadWithPhotoArray:(NSArray *)photoArray progress:(PTApiProgressBlock)progress success:(PTApiSuccessBlock)success failure:(PTApiFailureBlock)failure {
    self.successBlock = success;
    self.failureBlock = failure;
    self.progressBlock = progress;
    [self startUploadWithPhotoArray:photoArray];
}

- (void)startUploadWithPhotoArray:(NSArray *)photoArray {
    
    NBLog(@"上传地址:%@",self.url);
    _task = [_sessionManager POST:self.url parameters:self.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (photoArray.count > 0) {
            for (NSInteger i = 0; i < photoArray.count; i++) {
                UIImage *croppedImage = [photoArray objectAtIndex:i];
                if (croppedImage) {
                    NSData *imageData = UIImageJPEGRepresentation(croppedImage, 0.8);
                    [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"file%ld",i] fileName:[NSString stringWithFormat:@"%ld.jpg",i] mimeType:@"image/jpeg/png"];
                }
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [self handleUploadProgress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessTask:task response:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureTask:task error:error];
    }];
}

///上传 - 音频文件
- (void)startUploadWithVoiceFilePath:(NSString *)filePath {
    
    _task = [_sessionManager POST:self.url parameters:self.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *mediaData = [NSData dataWithContentsOfFile:filePath];
        [formData appendPartWithFileData:mediaData name:@"audio_file" fileName:@"audio_file.amr" mimeType:@"audio/x-amr"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [self handleUploadProgress:uploadProgress];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessTask:task response:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handleFailureTask:task error:error];
    }];
}
- (void)startUploadWithVoiceFilePath:(NSString *)filePath progress:(PTApiProgressBlock)progress success:(PTApiSuccessBlock)success failure:(PTApiFailureBlock)failure {
    self.successBlock = success;
    self.failureBlock = failure;
    self.progressBlock = progress;
    [self startUploadWithVoiceFilePath:filePath];
}

- (void)handleSuccessTask:(NSURLSessionDataTask*)task response:(id)responseObj {
    if (task.response && [task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)task.response;
        if (httpResponse.statusCode == 200) {    //返回200时缓存请求数据
            PTUpLoadFileResponse *response = [PTUpLoadFileResponse responseWithObject:responseObj];
            self.response = response;
            if (self.successBlock) {
                self.successBlock(response);
            }else if ([self.delegate respondsToSelector:@selector(apiRequestSuccessed:)]) {
                [self.delegate apiRequestSuccessed:self];
                return;
            }
        } else {
            self.error = [NSError errorWithDomain:@"StatusCodeError" code:99999 userInfo:@{NSLocalizedDescriptionKey:@"请求失败，返回码错误"}];
            if (self.failureBlock) {
                self.failureBlock(self.error);
            }else  if ([self.delegate respondsToSelector:@selector(apiRequestFailed:)]) {
                [self.delegate apiRequestFailed:self];
            }
        }
    }
}

- (void)handleUploadProgress:(NSProgress*)progress {
    self.uploadProgress = progress;
    if ([self.delegate respondsToSelector:@selector(apiRequestUploadProgress:)]) {
        [self.delegate apiRequestUploadProgress:self];
    } else if (self.progressBlock) {
        self.progressBlock(progress);
    }
}

- (void)handleFailureTask:(NSURLSessionDataTask*)task error:(NSError*)error {
    self.error = error;
    if (self.failureBlock) {
        self.failureBlock(error);
    }else if ([self.delegate respondsToSelector:@selector(apiRequestFailed:)]) {
        [self.delegate apiRequestFailed:self];
    }
}

@end
