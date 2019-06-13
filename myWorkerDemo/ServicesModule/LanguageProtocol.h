//
//  LanguageProtocol.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef LanguageProtocol_h
#define LanguageProtocol_h

@protocol LanguageProtocol <NSObject>

@required
/// 获取多语言
- (NSString * _Nonnull)getLocalizableStringWithKey:(NSString * _Nonnull)key
                                           comment:(NSString * _Nullable)comment;

@end

#endif /* LanguageProtocol_h */
