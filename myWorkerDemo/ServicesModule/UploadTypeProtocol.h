//
//  UploadTypeProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef UploadTypeProtocol_h
#define UploadTypeProtocol_h

#import <Foundation/Foundation.h>

@protocol UploadTypeProtocol<NSObject>
- (void)uploadFileData:(NSData *)data
              fileName:(NSString *)fileName
              progress:(void (^)(float value))progress
             completed:(void (^)(NSError *error, NSString *serverFileURL))completed;
@end

#endif /* UploadTypeProtocol_h */
