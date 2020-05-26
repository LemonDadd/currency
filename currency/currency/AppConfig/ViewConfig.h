//
//  ViewConfig.h
//  currency
//
//  Created by 关云秀 on 2020/5/26.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#ifndef ViewConfig_h
#define ViewConfig_h

//Plist方法
//读取UserDefaults 的p(key)
#define  kUserDefaultsRead(p) [[NSUserDefaults standardUserDefaults] stringForKey:(p)]
#define  kUserDefaultsSave(value,key)  [[NSUserDefaults standardUserDefaults]setObject:(value) forKey:(key)]
#define KCONFIGPLIST(p) [CacheTool getKeyValueWithConfigPlist:(p)]
#define KINFOPLIST(p) [CacheTool getKeyValueWithInfoPlist:(p)]
#define KSystemConfigPlist(p) [CacheTool getKeyValueWithSystemConfigPlist:(p)]

//APP外部版本号
#define APPVersion KINFOPLIST(@"CFBundleShortVersionString")
//APP应用名称
#define APPDisplayName KINFOPLIST(@"CFBundleDisplayName")

//APP BundleId
#define APPBundleId [[NSBundle mainBundle] bundleIdentifier]

//屏幕宽高
#define KSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define KNAVBAR_TOP_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define KNAVBAR_HEIGHT KNAVBAR_TOP_HEIGHT + 44.0f
#define KTABBAR_HEIGHT (KSCREEN_HEIGHT>=812.0f?68.0f*SCALAE+49.0f:49.0f)
#define KTABBAR_BOTTOM_HEIGHT (KSCREEN_HEIGHT>=812.0f?68.0f*SCALAE:0.0f)
#define KNAVBAR_IPHONEX_HEIGHT (KSCREEN_HEIGHT>=812.0f?88.0f:(IsiOS7Later?64.0f:44.0f))
/// 距离底部高度
#define KAPPLICATION_BOTTOM_HEIGHT (KSCREEN_HEIGHT>=812.0f?34.0f:0.0f)

// 颜色
#define KHEXCOLOR(c) [UIColor colorWithHex:c]
#define KHEXCOLORALPHA(c, a) [UIColor colorWithHex:c alpha:a]
#define KRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//字体
#define KFONTSIZE(f) [UIFont fontWithName:@"PingFangSC-Regular" size:(f)*(KSCREEN_WIDTH)/375.0]
#define KFONTBOLDSIZE(f) [UIFont fontWithName:@"PingFangSC-Medium" size:(f)*(KSCREEN_WIDTH)/375.0]
#define CYPingFangSCRegular(x)       [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define CYPingFangSCMedium(x)        [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define CYPingFangSCBold(x)          [UIFont fontWithName:@"PingFangSC-Semibold" size:x]
#define SFProDisplayBold(x)          [UIFont fontWithName:@"SFProDisplay-Bold" size:x]


//适配不同机型的View大小
#define kWidth(R) (R)*(KSCREEN_WIDTH)/375 //这里的320我是针对5s为标准适配的,如果需要其他标准可以修改
#define kHeight(R) (R)*(KSCREEN_HEIGHT)/667


#define ModuleType_4_header_height 44
#define ModuleType_4_shopCart_height 25
#define ModuleType_5_header_height 35

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define kMainColor          0xFFC500
#define kMainTextColor      0xff5400
#define kButtonColor        0x333333
#define kGetCouponColor     0x717171
#define kLineColor          0xededed
#define kRedColor           kMainTextColor
#define kDetailColor        0x222222
#define kTitleColor         0x333333
#define kSubTitleColor      0x666666
#define kSummaryColor       0xb2b2b2
#define kBackGroungColor    0xF5F5F5
#define KpageDotImage       0xccffff
#define kPlaceholderColor   0x999999
#define kWhiteColor         KHEXCOLOR(0xffffff)
#define kBlackColor         [UIColor blackColor]
#define kRandomColor        [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1]

//设备判断
#define CY_IsiPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)  //是否是iphone4
#define CY_IsiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphone5
#define CY_IsiPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)  //是否是iphone4s
#define CY_IsiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphone6
#define CY_IsiPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphone6p
#define CY_IsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphoneX
#define CY_IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)  //是否是iphoneXr
#define CY_IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)//是否是iPhoneXsMax

//判断iPhoneX所有系列
#define CY_IS_PhoneXAll (CY_IsiPhoneX || CY_IS_IPHONE_Xr || CY_IS_IPHONE_Xs_Max)
#define CY_Height_NavContentBar 44.0f
#define CY_Height_StatusBar (CY_IS_PhoneXAll? 44.0 : 20.0)
#define CY_Height_NavBar (CY_IS_PhoneXAll ? 88.0 : 64.0)
#define CY_Height_TabBar (CY_IS_PhoneXAll ? 83.0 : 49.0)
#define CY_Height_Bottom_SafeArea (CY_IS_PhoneXAll ? 34.0 : 0)
#define CY_Above_IPhone6 ([UIScreen mainScreen].bounds.size.width >= 375)
#define CY_IPhone6Scale(x) (CY_Above_IPhone6?(x):(KSCREEN_WIDTH*(x)/375.f))
#define CY_Sigle_Line_Height (1/[UIScreen mainScreen].scale)

#endif /* ViewConfig_h */
