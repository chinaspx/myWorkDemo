//
//  ComDefineConfig.h
//  PPTryst
//
//  Created by 焦梓杰 on 2018/8/24.
//  Copyright © 2018年 AsiaInnovations. All rights reserved.
//

#ifndef ComDefineConfig_h
#define ComDefineConfig_h

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds]).size.height
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds]).size.width

#define NavigationHeight  (IS_iPhoneX ? 88.f : 64.f)
//判断是否iPhone X
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhoneX / iPhoneXS
#define  isIphoneX_XS     (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (SCREEN_WIDTH == 414.f && SCREEN_HEIGHT == 896.f ? YES : NO)
//异性全面屏
#define  isFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)
// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (isFullScreen ? 34.f : 0.f)

#if DEBUG
//#define HttpApiName @"http://stage-api.52dongxin.net/"          //  aws 国际化 测试环境 - 测试数据
#define HttpApiName @"https://api.52dongxin.net/"                   //  国际化 - 线上数据
#else
//#define HttpApiName @"http://stage-api.52dongxin.net/"          //  aws 国际化 - 测试环境 - 测试数据
#define HttpApiName @"https://api.52dongxin.net/"                   //  国际化 线上数据
#endif

#define onExit \
rac_keywordify \
__strong rac_cleanupBlock_t metamacro_concat(rac_exitBlock_, __LINE__) __attribute__((cleanup(rac_executeCleanupBlock), unused)) = ^

#define Weakify(o) rac_keywordify __weak typeof(o) o##Weak = o;
#define Strongify(o) rac_keywordify __strong typeof(o) o = o##Weak;

/**
 * 判断各类型号
 */
#define iphone_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iphone_6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

/*******  -- 字符串转空 --  *****/
#define StringIsNullToEmpty(obj) ((!obj || obj.length <= 0) ? @"":obj)
/*******  -- IOS版本 --  *****/
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] doubleValue]
/*******  -- APP版本 --  *****/
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#endif /* ComDefineConfig_h */
