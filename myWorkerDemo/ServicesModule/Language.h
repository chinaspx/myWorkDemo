//
//  Language.h
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LanguageProtocol.h"

typedef NS_ENUM(NSUInteger, AppLanguage) {
    ///未知，跟随系统语言。
    AppLanguage_followSystem = 0,
    ///英语
    AppLanguage_en = 1,
    ///中文简体
    AppLanguage_zh_Hans=2,
    ///中文繁体
    AppLanguage_zh_Hant=3,
    ///中文繁体,香港
    AppLanguage_zh_Hant_HK=4,
    ///越南语
    AppLanguage_vi=5,
    ///韩语
    AppLanguage_ko=6,
    ///日语
    AppLanguage_ja=7,
    ///阿拉伯语
    AppLanguage_ar=8,
    ///葡萄牙语
    AppLanguage_pt=9,
    ///俄罗斯
    AppLanguage_ru=10,
    ///法语
    AppLanguage_fr=11,
    ///印尼语
    AppLanguage_id=12,
    ///西班牙语
    AppLanguage_es=13,
    ///马来西亚文
    AppLanguage_ms=14,
    ///泰语
    AppLanguage_th=15,
    ///土耳其语
    AppLanguage_tr=16,
    ///印地语
    AppLanguage_hi=17,
};

typedef NS_ENUM(NSUInteger, ULAppRegion) {
    ///未知，跟随系统地区
    ULAppRegion_followSystem = 0,
    ///英文区
    ULAppRegion_en=1,
    ///中文区
    ULAppRegion_hans=2,
    ///越南区
    ULAppRegion_vi=4,
    ///韩文区
    ULAppRegion_kr=5,
    ///日文区
    ULAppRegion_jp=6,
    ///葡萄牙区
    ULAppRegion_pt=7,
    ///俄罗斯区
    ULAppRegion_ru=8,
    ///法语区
    ULAppRegion_fr=9,
    ///中东地区
    ULAppRegion_ca=10,
    ///繁体区，台湾
    ULAppRegion_hant_TW=3,
    ///繁体区，香港
    ULAppRegion_hant_HK=11,
    ///繁体区，澳门
    ULAppRegion_hant_MO=12,
    ///印度尼西亚
    ULAppRegion_id=13,
    ///西班牙
    ULAppRegion_es=14,
    ///马来西亚
    ULAppRegion_my=15,
    ///新加坡
    ULAppRegion_sg=16,
    ///泰国
    ULAppRegion_th=17,
    ///土耳其
    ULAppRegion_tr=18,
    ///斯里兰卡
    ULAppRegion_lk=19,
    ///新西兰
    ULAppRegion_nz=20,
    ///澳大利亚
    ULAppRegion_au=21,
    ///印地语区
    ULAppRegion_hi=22,
};

@interface Language : NSObject<LanguageProtocol>

@property(readonly) NSString *currentLanguage;
@property(readonly) NSString *currentLanguageDesc;
@property(readonly) NSInteger languageIndex;
@property(readonly) AppLanguage languageType;
///是否是阿拉伯语言
@property (readonly) BOOL isArabicLanguage;

+ (NSArray<NSDictionary<NSString *, NSString *> *> *)allSupportLanguage;
///存储当前语言
+ (void)saveCurrentSystemLanguage;

- (NSBundle *)bundle;

- (instancetype)initWithLanguage:(NSString *)languageKey;

///获取当前APP使用的语言（枚举类型）
+ (AppLanguage)getCurrentAPPLanguage;
///获取当前APP语言（字符串类型）
+ (NSString *)getStringByCurrentLanguage:(AppLanguage)curLanguage;
#pragma mark -
#pragma mark - Country
///获取当前手机系统所在地区（枚举类型）
+ (ULAppRegion)getCurrentSystemRegion;
+ (NSString *)getCurrentSystemRegionString;
+ (ULAppRegion)getCurrentAccountRegion;
///获取当前的语言，上报地区接口，自行拼接的，符合后台接口
+ (NSString *)getCurrentAPPLanguageAndRegion;
@end

