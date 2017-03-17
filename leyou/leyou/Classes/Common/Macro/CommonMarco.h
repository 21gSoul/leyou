//
//  CommonMarco.h
//  leyou
//
//  Created by lu.liu on 2017/3/9.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#ifndef CommonMarco_h
#define CommonMarco_h

// RGB颜色
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXRGBCOLOR(h)      RGBCOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF))
#define HEXRGBACOLOR(h,a)   RGBACOLOR(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)


// 屏幕尺寸
#define SCREEN_RECT         [UIScreen mainScreen].bounds
#define SCREEN_SIZE         [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH        (SCREEN_SIZE.width)
#define SCREEN_HEIGHT       (SCREEN_SIZE.height)
#define NAVIGATIONBAR_HEIGHT  64
#define TABBAR_HEIGHT  49
// Device相关

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//设备判断
#define IOSVERSION [[[UIDevice currentDevice] systemVersion] doubleValue]
#define IS_IPHONE4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 1125/2001 6p的放大屏幕尺寸
#define IS_IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) ||CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size): NO)

#define kSCREEN_WRATE (CGRectGetWidth([UIScreen mainScreen].bounds)/375.0f)
#define kSCREEN_HRATE (CGRectGetHeight([UIScreen mainScreen].bounds)/667.0f)

#define APP ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#endif /* CommonMarco_h */
