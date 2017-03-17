//
//  UIColor+DefaultColor.m
//  leyou
//
//  Created by lu.liu on 2017/3/9.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "UIColor+DefaultColor.h"
#import "CommonMarco.h"
@implementation UIColor (DefaultColor)


+ (UIColor *)getTitleColor{
   return HEXRGBCOLOR(0x333333);
}

+ (UIColor *)getMainColor{
   return HEXRGBCOLOR(0x1296db);
}

+ (UIColor *)getMainTextColor{
   return HEXRGBCOLOR(0x666666);
}

+ (UIColor *)getSubTextColor{
    return HEXRGBCOLOR(0x999999);
}

+ (UIColor *)getBgColor{
    return RGBCOLOR(240, 240, 240);
}
@end
