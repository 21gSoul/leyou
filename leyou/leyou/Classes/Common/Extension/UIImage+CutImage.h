//
//  UIImage+CutImage.h
//  UITest
//
//  Created by 刘璐 on 16/11/2.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CutImage)

- (UIImage *)cutCircularImage:(UIImage *)image;
- (UIImage *)cutCircularImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *)borderColor;
@end
