//
//  GHBaseDefine.h
//  GHFoundation
//
//  Created by Rong on 2018/2/9.
//  Copyright © 2018年 Rong. All rights reserved.
//

#ifndef GHBaseDefine_h
#define GHBaseDefine_h

/*
 iPhone 4/4s 宽高: 320 x 480 -- @2x
 iPhone 5/SE 宽高: 320 x 568 -- @2x
 iPhone 6/7/8  宽高: 375 x 667 -- @2x
 iPhone 6/7/8 plus 宽高: 414 x 736 -- @3x
 iPhone X 宽高: 375 x 812 -- @3x
 */

// 设备类型
#define isiPhone4S()          (SCREEN_HEIGHT == 480)
#define isiPhone5()           (SCREEN_HEIGHT == 568)
#define isiPhone6()           (SCREEN_HEIGHT == 667)
#define isiPhone6P()          (SCREEN_HEIGHT == 736)
#define isiPhoneX()           (Screen_Height == 812)


// 屏幕宽高
// 需要横屏或者竖屏，获取屏幕宽度与高度
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define GHScreenWidth    ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define GHScreenHeight   ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define GHScreenSize     ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)

#else

#define GHScreenWidth    [UIScreen mainScreen].bounds.size.width
#define GHScreenHeight   [UIScreen mainScreen].bounds.size.height
#define GHScreenSize    [UIScreen mainScreen].bounds.size

#endif


// RGB颜色/设置RGBA颜色
#define GHRGBColor(r, g, b)      GHRGBAColor(r, g, b, 1.0)
#define GHRGBAColor(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机颜色
#define GHRandomColor            GHRGBAColor((arc4random_uniform(256) / 255.0), (arc4random_uniform(256) / 255.0), (arc4random_uniform(256) / 255.0), 1.0)
// 十六进制颜色
#define GHHexColor(hex)          [UIColor colorWithRed:(((hex & 0xFF0000) >> 16) / 255.0) green:(((hex & 0x00FF00) >> 8 ) / 255.0) blue:((hex & 0x0000FF) / 255.0) alpha:1.0]

// Log
#ifdef DEBUG
#define GHLog(...) NSLog(@"%s (Line = %d) \n\n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#define GHLog(format, ...)  printf("[%s] %s [%d line] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define GHLog(...)
#endif

// 弱对象/强对象
#define WeakObject(obj, weakObj)      __weak typeof(obj) weakObj = obj;
#define WeakSelf()                    WeakObject(self,weakSelf);

#define strongObject(obj, strongObj)  __strong typeof(obj) strongObj = obj;
#define strongSelf(self)              strongObject(self,strongSelf)

// 设置 view 圆角和边框颜色宽度
#define GHViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// 角度转换弧度
#define GHDegreesToRadian(x)        (M_PI * (x) / 180.0)
// 弧度转换角度
#define GHRadianToDegrees(radian)   ((radian*180.0) / (M_PI))

#define GHKeyWindow   [UIApplication sharedApplication].keyWindow

// 当前系统语言
#define GHCurrentLanguage   ([[NSLocale preferredLanguages] objectAtIndex:0])

// 当前系统版本
#define GHCurrentSystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]

// 判断是否为iPhone
#define GH_is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define GH_is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 判断是否为ipod
#define GH_is_iPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 判断是否为 iPhone 5/SE
#define GH_is_iPhone_5_SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define GH_is_iPhone_6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define GH_is_iPhone6P_6sP [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f


#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

// ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

// 沙盒相关目录
#define GHTempPath       NSTemporaryDirectory()
#define GHDocumentPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define GHCachePath      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#endif /* GHBaseDefine_h */
