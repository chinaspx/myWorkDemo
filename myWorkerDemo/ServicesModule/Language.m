//
//  Language.m
//  PPTryst
//
//  Created by chinaspx on 2018/8/21.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#import "Language.h"
#import "AppEnvironment.h"

#pragma mark -
#pragma mark - LangaugeOfCountry
///多语言UserDefault中key
static NSString * const kUserDefaultAppLanguage         = @"PPTrystAppLanguage";


///"AR" 指 中东地区
static NSString * const kCountryCodeMiddelEastKey       = @"AR";
///中国的国家码
static NSString * const kCountryCodeChina               = @"CN";
///中文[大中华区]
static NSString * const kLanguageChina                  = @"zh";
//简体中文
static NSString * const kLanguageChina_Hans             = @"zh-Hans";
//繁体中文
static NSString * const kLanguageChina_Hant_TW          = @"zh-Hant-TW";
//繁体中文,香港
static NSString * const kLanguageChina_Hant_HK          = @"zh-Hant-HK";
///英语[洋人世界]
static NSString * const kLanguageEnglish                = @"en";
///越南语[交趾郡]
static NSString * const kLanguageVietnam                = @"vi";
///日语[东瀛.扶桑]
static NSString * const kLanguageJapan                  = @"ja";
///阿拉伯语[中东世界]
static NSString * const kLanguageArabia                 = @"ar";
///葡萄牙语[葡萄牙]
static NSString * const kLanguagePT                     = @"pt";
///俄罗斯语[罗刹国]
static NSString * const kLanguageRussia                 = @"ru";
///法语[法国]
static NSString * const kLanguageFrance                 = @"fr";
///韩国语[韩国]
static NSString * const kLanguageKorea                  = @"ko";
///印尼语[印度尼西亚.南洋]
static NSString * const kLanguageIndonesian             = @"id";
///印地语[天竺地]
static NSString * const kLanguageHindi                  = @"hi";
///西班牙语
static NSString * const kLanguageSpanish                = @"es";
///马来西亚文
static NSString * const kLanguageMalay                  = @"ms";
///泰语
static NSString * const kLanguageThai                   = @"th";
///土耳其语
static NSString * const kLanguageTurkish                = @"tr";

@implementation Language {
    NSBundle *_bundle;
}

#pragma mark -
#pragma mark - LifeCyle
- (BOOL)isArabicLanguage {
    return AppLanguage_ar == self.languageType;
}


///保存，当前的系统语言（跟随机器）
+ (void)saveCurrentSystemLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *allLanguages = [NSLocale preferredLanguages];//[defaults objectForKey:@"AppleLanguages"];//系统Key无需修改
    NSString *curLanguage = [allLanguages objectAtIndex:0];
    
    //中文简体
    if ([curLanguage hasPrefix:kLanguageChina_Hans]) {
        curLanguage = kLanguageChina_Hans;
    }
    //中文繁体
    else if ([curLanguage hasPrefix:@"zh-"]) {
        if ([curLanguage hasPrefix:@"zh-Hant-HK"]) {
            curLanguage = kLanguageChina_Hant_HK;
        } else {
            curLanguage = kLanguageChina_Hant_TW;
        }
    }
    //英语
    else if ([curLanguage hasPrefix:kLanguageEnglish]) {
        curLanguage = kLanguageEnglish;
    }
    //越南语
    else if ([curLanguage hasPrefix:kLanguageVietnam]) {
        curLanguage = kLanguageVietnam;
    }
    //日语
    else if ([curLanguage hasPrefix:kLanguageJapan]) {
        curLanguage = kLanguageJapan;
    }
    //阿拉伯语
    else if ([curLanguage hasPrefix:kLanguageArabia]) {
        curLanguage = kLanguageArabia;
    }
    //葡萄牙语
    else if ([curLanguage hasPrefix:kLanguagePT]) {
        curLanguage = kLanguagePT;
    }
    //俄罗斯语
    else if ([curLanguage hasPrefix:kLanguageRussia]) {
        curLanguage = kLanguageRussia;
    }
    //法语
    else if ([curLanguage hasPrefix:kLanguageFrance]) {
        curLanguage = kLanguageFrance;
    }
    //韩语
    else if ([curLanguage hasPrefix:kLanguageKorea]) {
        curLanguage = kLanguageKorea;
    }
    //印尼语
    else if ([curLanguage hasPrefix:kLanguageIndonesian]) {
        curLanguage = kLanguageIndonesian;
    }
    //印度语
    else if ([curLanguage hasPrefix:kLanguageHindi]) {
        curLanguage = kLanguageHindi;
    }
    //西班牙语
    else if ([curLanguage hasPrefix:kLanguageSpanish]) {
        curLanguage = kLanguageSpanish;
    }
    //马来西亚文
    else if ([curLanguage hasPrefix:kLanguageMalay]) {
        curLanguage = kLanguageMalay;
    }
    //泰语
    else if ([curLanguage hasPrefix:kLanguageThai]) {
        curLanguage = kLanguageThai;
    }
    //土耳其语
    else if ([curLanguage hasPrefix:kLanguageTurkish]) {
        curLanguage = kLanguageTurkish;
    }
    //默认英语
    else {
        curLanguage = kLanguageEnglish;
    }
    NBLog(@"saveCurrentSystemLanguage curLanguage:%@", curLanguage);
    ///设置APP，最终要使用的是哪一种语言。
    [defaults setObject:curLanguage forKey:kUserDefaultAppLanguage];
    [defaults synchronize];
}

///保存，当前用户自定义语言（热切换）
+ (void)saveCurrentCustomLanguage:(AppLanguage)curLanguage {
    NSString *languageString = [self getStringByCurrentLanguage:curLanguage];
    ///设置APP，最终要使用的是哪一种语言。
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:languageString forKey:kUserDefaultAppLanguage];
    [defaults synchronize];
}

#pragma mark -
#pragma mark - Core
- (NSString *)localizedStringWithKey:(NSString *)key value:(NSString *)value {
    return [self.bundle localizedStringForKey:key value:value table:nil];
}

- (NSString *)localizedStringWithKey:(NSString *)key value:(NSString *)value table:(NSString *)table {
    return [self.bundle localizedStringForKey:key value:value table:table];
}

#pragma mark -
#pragma mark - Get
///获取当前APP使用的语言（枚举类型）
+ (AppLanguage)getCurrentAPPLanguage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *curLanguage = [defaults stringForKey:kUserDefaultAppLanguage];
    return AppLanguage_zh_Hant;     //  - 台湾适配，后期修正 - fixbug
    //中文简体
    if ([curLanguage isEqualToString:kLanguageChina_Hans]) {
        return AppLanguage_zh_Hans;
    }
    //中文繁体
    else if ([curLanguage hasPrefix:@"zh-"]) {
        if ([curLanguage hasPrefix:kLanguageChina_Hant_HK]) {
            return AppLanguage_zh_Hant_HK;
        }
        return AppLanguage_zh_Hant;
    }
    //英语
    else if ([curLanguage isEqualToString:kLanguageEnglish]) {
        return AppLanguage_en;
    }
    //越南语
    else if ([curLanguage isEqualToString:kLanguageVietnam]) {
        return AppLanguage_vi;
    }
    //日语
    else if ([curLanguage isEqualToString:kLanguageJapan]) {
        return AppLanguage_ja;
    }
    //阿拉伯语
    else if ([curLanguage isEqualToString:kLanguageArabia]) {
        return AppLanguage_ar;
    }
    //葡萄牙
    else if ([curLanguage isEqualToString:kLanguagePT]) {
        return AppLanguage_pt;
    }
    //俄罗斯
    else if ([curLanguage isEqualToString:kLanguageRussia]) {
        return AppLanguage_ru;
    }
    //法语
    else if ([curLanguage isEqualToString:kLanguageFrance]) {
        return AppLanguage_fr;
    }
    //韩语
    else if ([curLanguage hasPrefix:kLanguageKorea]) {
        return AppLanguage_ko;
    }
    //印尼语
    else if ([curLanguage isEqualToString:kLanguageIndonesian]) {
        return AppLanguage_id;
    }
    //印地语
    else if ([curLanguage isEqualToString:kLanguageHindi]) {
        return AppLanguage_hi;
    }
    //西班牙语
    else if ([curLanguage hasPrefix:kLanguageSpanish]) {
        return AppLanguage_es;
    }
    //马来西亚文
    else if ([curLanguage hasPrefix:kLanguageMalay]) {
        return AppLanguage_ms;
    }
    //泰语
    else if ([curLanguage hasPrefix:kLanguageThai]) {
        return AppLanguage_th;
    }
    //土耳其语
    else if ([curLanguage hasPrefix:kLanguageTurkish]) {
        return AppLanguage_tr;
    }
    //默认英语
    else {
        return AppLanguage_en;
    }
}

///获取当前APP语言（字符串类型）
+ (NSString *)getStringByCurrentLanguage:(AppLanguage)curLanguage {
    switch (curLanguage) {
            //简体中文
        case AppLanguage_zh_Hans:
            return kLanguageChina_Hans;
            break;
            //繁体中文
        case AppLanguage_zh_Hant:
            return kLanguageChina_Hant_TW;
            break;
            //繁体中文,香港
        case AppLanguage_zh_Hant_HK:
            return kLanguageChina_Hant_HK;
            break;
            //英语
        case AppLanguage_en:
            return kLanguageEnglish;
            break;
            //越南语
        case AppLanguage_vi:
            return kLanguageVietnam;
            break;
            //日语
        case AppLanguage_ja:
            return kLanguageJapan;
            break;
            //阿拉伯语
        case AppLanguage_ar:
            return kLanguageArabia;
            break;
        case AppLanguage_pt:
            return kLanguagePT;
            break;
        case AppLanguage_ru:
            return kLanguageRussia;
            break;
        case AppLanguage_fr:
            return kLanguageFrance;
            break;
        case AppLanguage_ko:
            return kLanguageKorea;
            break;
        case AppLanguage_id:
            return kLanguageIndonesian;
            break;
        case AppLanguage_hi:
            return kLanguageHindi;
            break;
        case AppLanguage_es:
            return kLanguageSpanish;
            break;
        case AppLanguage_ms:
            return kLanguageMalay;
            break;
        case AppLanguage_th:
            return kLanguageThai;
            break;
        case AppLanguage_tr:
            return kLanguageTurkish;
            break;
            //默认
        default:
            return kLanguageEnglish;
            break;
    }
}

+ (NSArray<NSDictionary<NSString *, NSString *> *> *)allSupportLanguage {
    return @[
            @{@"zh-Hans": @"简体中文"},
            @{@"en": @"English"},
            @{@"zh-Hant": @"繁體中文（台灣）"},
            @{@"zh-Hant-HK": @"繁體中文（香港"},
            @{@"vi": @"Tiếng Việt"},
            @{@"ja": @"日本語"},
            @{@"ar": @"العربية"},
            @{@"fr": @"Français"},
            @{@"pt": @"Português"},
            @{@"ru": @"Pусский"},
            @{@"ko": @"한국어"},
            @{@"id": @"Bahasa Indonesia"},
            @{@"es": @"Español"},
            @{@"ms": @"Bahasa Malaysia"},
            @{@"th": @"ภาษาไทย"},
            @{@"tr": @"Türkçe"}
    ];
}

- (NSBundle *)bundle {
    if (!_bundle) {
        NSString *tk = _currentLanguage;
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:tk ofType:@"lproj"];
        _bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return _bundle;
}

- (instancetype)initWithLanguage:(NSString *)languageKey {
    self = [super init];
    __block BOOL find = NO;
    if (self) {
        _currentLanguage = languageKey;
        [[Language allSupportLanguage] enumerateObjectsUsingBlock:^(NSDictionary<NSString *, NSString *> *obj, NSUInteger idx, BOOL *stop) {
//            NSLog(@"obj.allKeys.firstObject :%@", obj.allKeys.firstObject );
            if ([obj.allKeys.firstObject isEqualToString:self->_currentLanguage]) {
                NBLog(@"self->_currentLanguage :%@", self->_currentLanguage);
                self->_currentLanguageDesc = obj.allValues.firstObject;
                NBLog(@"self->_currentLanguageDesc :%@", self->_currentLanguageDesc);
                self->_languageIndex = idx;
                find = YES;
                *stop = YES;
            }
        }];
    }
    return find ? self : nil;
}

///获取当前APP使用的语言（枚举类型）
- (AppLanguage)languageType {
    NSString *curLanguage = _currentLanguage;
    //中文简体
    if ([curLanguage isEqualToString:kLanguageChina_Hans]) {
        return AppLanguage_zh_Hans;
    }
    //中文繁体
    else if ([curLanguage hasPrefix:@"zh-"]) {
        if ([curLanguage hasPrefix:kLanguageChina_Hant_HK]) {
            return AppLanguage_zh_Hant_HK;
        }
        return AppLanguage_zh_Hant;
    }
    //英语
    else if ([curLanguage isEqualToString:kLanguageEnglish]) {
        return AppLanguage_en;
    }
    //越南语
    else if ([curLanguage isEqualToString:kLanguageVietnam]) {
        return AppLanguage_vi;
    }
    //日语
    else if ([curLanguage isEqualToString:kLanguageJapan]) {
        return AppLanguage_ja;
    }
    //阿拉伯语
    else if ([curLanguage isEqualToString:kLanguageArabia]) {
        return AppLanguage_ar;
    }
    //葡萄牙
    else if ([curLanguage isEqualToString:kLanguagePT]) {
        return AppLanguage_pt;
    }
    //俄罗斯
    else if ([curLanguage isEqualToString:kLanguageRussia]) {
        return AppLanguage_ru;
    }
    //法语
    else if ([curLanguage isEqualToString:kLanguageFrance]) {
        return AppLanguage_fr;
    }
    //韩语
    else if ([curLanguage hasPrefix:kLanguageKorea]) {
        return AppLanguage_ko;
    }
    //印尼语
    else if ([curLanguage isEqualToString:kLanguageIndonesian]) {
        return AppLanguage_id;
    }
    //印地语
    else if ([curLanguage isEqualToString:kLanguageHindi]) {
        return AppLanguage_hi;
    }
    //西班牙语
    else if ([curLanguage hasPrefix:kLanguageSpanish]) {
        return AppLanguage_es;
    }
    //马来西亚文
    else if ([curLanguage hasPrefix:kLanguageMalay]) {
        return AppLanguage_ms;
    }
    //泰语
    else if ([curLanguage hasPrefix:kLanguageThai]) {
        return AppLanguage_th;
    }
    //土耳其语
    else if ([curLanguage hasPrefix:kLanguageTurkish]) {
        return AppLanguage_tr;
    }
    //默认英语
    else {
        return AppLanguage_en;
    }
}

#pragma mark -
#pragma mark - Country
///获取当前手机系统所在地区（枚举类型）
+ (ULAppRegion)getCurrentSystemRegion {
//    return [Language regionIdetifier:[[NSLocale currentLocale] localeIdentifier]];
    return ULAppRegion_hant_TW;
}

+ (NSString *)getCurrentSystemRegionString {
    
    ULAppRegion type = [self getCurrentSystemRegion];
    
    //简体中文区
    if (type == ULAppRegion_hans) {
        return kCountryCodeChina;
    }
    
    //繁体中文区，台湾
    if (type == ULAppRegion_hant_TW) {
        return @"TW";
    }
    
    //繁体中文区，香港
    if (
        type == ULAppRegion_hant_HK) {
        return @"HK";
    }
    
    //繁体中文区，澳门
    if (type == ULAppRegion_hant_MO) {
        return @"MO";
    }
    
    //越南语区
    if (type == ULAppRegion_vi) {
        return @"VN";
    }
    //韩语区
    if (type == ULAppRegion_kr) {
        return @"KR";
    }
    //日语区
    if (type == ULAppRegion_jp) {
        return @"JP";
    }
    //葡萄牙区
    if (type == ULAppRegion_pt) {
        return  @"PT";
    }
    //俄罗斯区
    if (type == ULAppRegion_ru) {
        return @"RU";
    }
    //法语区
    if (type == ULAppRegion_fr) {
        return @"FR";
    }
    //阿拉伯语区
    if (ULAppRegion_ca == type) {
        return kCountryCodeMiddelEastKey;
    }
    //印度尼西亚区
    if (type == ULAppRegion_id) {
        return @"ID";
    }
    //印地区
    if (type == ULAppRegion_hi) {
        return @"IN";
    }
    //西班牙区
    if (type == ULAppRegion_es) {
        return @"ES";
    }
    //马来西亚区
    if (type == ULAppRegion_my) {
        return @"MY";
    }
    //泰国
    if (type == ULAppRegion_th) {
        return @"TH";
    }
    //土耳其
    if (type == ULAppRegion_tr) {
        return @"TR";
    }
    //默认英语区(我选美帝国主义)
    return @"US";
}



+ (ULAppRegion)getCurrentAccountRegion {
    return [Language regionIdetifier:[@"_" stringByAppendingString:[self getCurrentSystemRegionString]]];
}

+ (ULAppRegion)regionIdetifier:(NSString *)identifier {
    
    //简体中文区
    if ([identifier hasSuffix:@"_CN"]) {
        return ULAppRegion_hans;
    }
    //繁体中文区_台湾
    if ([identifier hasSuffix:@"_TW"]) {
        return ULAppRegion_hant_TW;
    }
    //繁体中文区_香港
    if ([identifier hasSuffix:@"_HK"]) {
        return ULAppRegion_hant_HK;
    }
    //繁体中文区_澳门
    if ([identifier hasSuffix:@"_MO"]) {
        return ULAppRegion_hant_MO;
    }
    //越南语区
    if ([identifier hasSuffix:@"_VN"]) {
        return ULAppRegion_vi;
    }
    //韩语区
    if ([identifier hasSuffix:@"_KR"]) {
        return ULAppRegion_kr;
    }
    //日语区
    if ([identifier hasSuffix:@"_JP"]) {
        return ULAppRegion_jp;
    }
    //葡萄牙区
    if ([identifier hasSuffix:@"_PT"]) {
        return ULAppRegion_pt;
    }
    //俄罗斯区
    if ([identifier hasSuffix:@"_RU"]) {
        return ULAppRegion_ru;
    }
    //法语区
    if ([identifier hasSuffix:@"_FR"]) {
        return ULAppRegion_fr;
    }
    //阿拉伯语区
    if ([self isCentralAsia:identifier]) {
        return ULAppRegion_ca;
    }
    //印度尼西亚区
    if ([identifier hasSuffix:@"_ID"]) {
        return ULAppRegion_id;
    }
    //印地语
    if ([identifier hasSuffix:@"_IN"]) {
        return ULAppRegion_hi;
    }
    //西班牙区
    if ([identifier hasSuffix:@"_ES"]) {
        return ULAppRegion_es;
    }
    //马来西亚
    if ([identifier hasSuffix:@"_MY"]) {
        return ULAppRegion_my;
    }
    //新加坡
    if ([identifier hasSuffix:@"_SG"]) {
        return ULAppRegion_sg;
    }
    //泰国
    if ([identifier hasSuffix:@"_TH"]) {
        return ULAppRegion_th;
    }
    //土耳其
    if ([identifier hasSuffix:@"_TR"]) {
        return ULAppRegion_tr;
    }
    //斯里兰卡
    if ([identifier hasSuffix:@"_LK"]) {
        return ULAppRegion_lk;
    }
    //新西兰
    if ([identifier hasSuffix:@"_NZ"]) {
        return ULAppRegion_nz;
    }
    //澳大利亚
    if ([identifier hasSuffix:@"_AU"]) {
        return ULAppRegion_au;
    }
    
    //默认英语区
    return ULAppRegion_en;
}

///获取当前的语言，上报地区接口，自行拼接的，符合后台接口
+ (NSString *)getCurrentAPPLanguageAndRegion {
    NSString *curLanguageAndRegion = @"";
    AppLanguage languageType = [self getCurrentAPPLanguage];
    
    switch (languageType) {
            //中文简体
        case AppLanguage_zh_Hans:
            curLanguageAndRegion = @"zh-Hans";
            break;
            //中文繁体
        case AppLanguage_zh_Hant:
            curLanguageAndRegion = @"zh-Hant";
            break;
            //中文繁体，香港
        case AppLanguage_zh_Hant_HK:
            curLanguageAndRegion = @"zh-Hant-HK";
            break;
            //越南语
        case AppLanguage_vi:
            curLanguageAndRegion = @"vi";
            break;
            //日语
        case AppLanguage_ja:
            curLanguageAndRegion = @"ja";
            break;
            // 阿拉伯语
        case AppLanguage_ar:
            curLanguageAndRegion = @"ar";
            break;
            //葡萄牙语
        case AppLanguage_pt:
            curLanguageAndRegion = @"pt";
            break;
            //俄罗斯语
        case AppLanguage_ru:
            curLanguageAndRegion = @"ru";
            break;
            //法语
        case AppLanguage_fr:
            curLanguageAndRegion = @"fr";
            break;
            //韩语
        case AppLanguage_ko:
            curLanguageAndRegion = @"kr";
            break;
            //印尼语
        case AppLanguage_id:
            curLanguageAndRegion = @"id";
            break;
            //印地语
        case AppLanguage_hi:
            curLanguageAndRegion = @"hi";
            break;
            //西班牙语
        case AppLanguage_es:
            curLanguageAndRegion = @"sp";
            break;
            //马来西亚文
        case AppLanguage_ms:
            curLanguageAndRegion = @"ms";
            break;
            //泰语
        case AppLanguage_th:
            curLanguageAndRegion = @"ta";
            break;
            //土耳其语
        case AppLanguage_tr:
            curLanguageAndRegion = @"tr";
            break;
            //默认英语
        default:
            curLanguageAndRegion = @"en";
            break;
    }
//    return curLanguageAndRegion;
    return @"zh-Hant";
}

///是否是中东地区
+ (BOOL)isCentralAsia:(NSString *)identifier {
    if (identifier.length == 0) {
        identifier = [[NSLocale currentLocale] localeIdentifier];
    }
    /*
     @"SA",@"EG",@"DZ",@"MA",@"TN",@"LY",
     @"YE",@"SS",@"DJ",@"KM",@"SO",@"MR",
     @"AE",@"OM",@"KW",@"QA",@"BH",@"JO",
     @"LB",@"PS",@"IQ",
     
     @"SD",@"SY"
     */
    if (//沙特阿拉伯
        [identifier hasSuffix:@"_SA@calendar=gregorian"] ||
        //埃及
        [identifier hasSuffix:@"_EG"] ||
        //阿尔及利亚
        [identifier hasSuffix:@"_DZ"] ||
        //摩洛哥
        [identifier hasSuffix:@"_MA"] ||
        //突尼斯
        [identifier hasSuffix:@"_TN"] ||
        //利比亚
        [identifier hasSuffix:@"_LY"] ||
        //也门
        [identifier hasSuffix:@"_YE"] ||
        //南苏丹
        [identifier hasSuffix:@"_SS"] ||
        //吉布提
        [identifier hasSuffix:@"_DJ"] ||
        //科摩罗
        [identifier hasSuffix:@"_KM"] ||
        //索马里
        [identifier hasSuffix:@"_SO"] ||
        //毛里塔尼亚
        [identifier hasSuffix:@"_MR"] ||
        //阿联酋
        [identifier hasSuffix:@"_AE"] ||
        //阿曼
        [identifier hasSuffix:@"_OM"] ||
        //科威特
        [identifier hasSuffix:@"_KW"] ||
        //卡塔尔
        [identifier hasSuffix:@"_QA"] ||
        //巴林
        [identifier hasSuffix:@"_BH"] ||
        //约旦
        [identifier hasSuffix:@"_JO"] ||
        //黎巴嫩
        [identifier hasSuffix:@"_LB"] ||
        //巴勒斯坦地区
        [identifier hasSuffix:@"_PS"] ||
        //伊拉克
        [identifier hasSuffix:@"_IQ"] ||
        //以色列
        [identifier hasSuffix:@"_IL"] ||
        //阿富汗
        [identifier hasSuffix:@"_AF@calendar=gregorian"]||
        //土耳其
        [identifier hasSuffix:@"_TR"] ||
        //塞浦路斯
        [identifier hasSuffix:@"_CY"] ||
        //伊朗
        [identifier hasSuffix:@"_IR"]
        
        //add: 苏丹
        || [identifier hasSuffix:@"_SD"]
        //add: 叙利亚
        || [identifier hasSuffix:@"_SY"]
        )
    {
        return YES;
    }
    
    return NO;
}

#pragma mark -
#pragma mark - LanguageProtocol
- (NSString *)getLocalizableStringWithKey:(NSString *)key comment:(NSString *)comment {
    return [self.bundle localizedStringForKey:key value:@"" table:nil];
}

@end

