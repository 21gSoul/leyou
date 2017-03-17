
//
//  NSString+Extension.m
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGFloat)clacTextHeight:(UIFont *)font width:(CGFloat)width{
    if (!font) {
        return -1;
    }
    if (width <= 0) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
    }
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
}
@end
