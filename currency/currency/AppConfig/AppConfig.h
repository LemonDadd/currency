//
//  AppConfig.h
//  currency
//
//  Created by 关云秀 on 2020/5/26.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

#define TempImage           @"https://wx1.sinaimg.cn/mw690/695f1cd4ly1g24mutwb9cj20hs0qo0tx.jpg"

// APP BundleId
#define APPBundleId [[NSBundle mainBundle] bundleIdentifier]

//SDK版本
#define IOSVersion       [[[UIDevice currentDevice] systemVersion] floatValue]
#define IsiOS7Later      !(IOSVersion < 7.0)
#define IsiOS71Later     !(IOSVersion <= 7.0)
#define IsiOS8Later      !(IOSVersion < 8.0)
#define IsiOS10Later     !(IOSVersion < 10.0)
#define IsiOS11Later     !(IOSVersion < 11.0)
#define IsiPhoneX        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhoneX
#define iPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
//判断iPhoneX序列（iPhoneX，iPhoneXs，iPhoneXs Max）
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPHoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhoneXsMax
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)

// weakself
#define KWeakSelf __weak __typeof(self)weakSelf = self

#define QQW_Weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define QQW_Strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __typeof__(x) x = __weak_##x##__; if (!x)return;\
_Pragma("clang diagnostic pop")

//设计切图计算比例
#define SCALAE KSCREEN_WIDTH/375.0/2.0

// 本地化存储
#define ND [NSUserDefaults standardUserDefaults]



#define HomePageSize      30

//日志打印
#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define DLog(...) printf("%s: %s 第%d行: %s\n\n",[[NSString lr_stringDate] UTF8String], [LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define DLog(...)
#endif

//-------------------单例化一个类-------------------------//
#define DEFINE_SINGLETON_INTERFACE(className) \
+ (className *)shared##className;


#define DEFINE_SINGLETON_IMPLEMENTATION(className) \
static className *shared##className = nil; \
static dispatch_once_t pred; \
\
+ (className *)shared##className { \
dispatch_once(&pred, ^{ \
shared##className = [[super allocWithZone:NULL] init]; \
if ([shared##className respondsToSelector:@selector(setUp)]) {\
[shared##className setUp];\
}\
}); \
return shared##className; \
} \
\
+ (id)allocWithZone:(NSZone *)zone { \
return [self shared##className];\
} \
\
- (id)copyWithZone:(NSZone *)zone { \
return self; \
}
//-------------------单例化一个类-------------------------//



//-------------------NSUserDefaults-------------------------//
#endif /* AppConfig_h */
