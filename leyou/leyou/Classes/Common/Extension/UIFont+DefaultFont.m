//
//  UIColor+DefaultFont.m
//  leyou
//
//  Created by lu.liu on 2017/3/9.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "UIFont+DefaultFont.h"
#import "CommonMarco.h"
@implementation UIFont (DefaultFont)
+ (UIFont *)getMainFont{
    return [UIFont systemFontOfSize:18 * kSCREEN_HRATE];
}

+ (UIFont *)getTitleFont{
    return [UIFont systemFontOfSize:16 * kSCREEN_HRATE];
}

+ (UIFont *)getSubFont{
    return [UIFont systemFontOfSize:14 * kSCREEN_HRATE];
}

+ (UIFont *)getSupFont{
    return [UIFont systemFontOfSize:12 * kSCREEN_HRATE];
}
@end
