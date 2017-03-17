//
//  UIImage+CutImage.m
//  UITest
//
//  Created by 刘璐 on 16/11/2.
//  Copyright © 2016年 刘璐. All rights reserved.
//

#import "UIImage+CutImage.h"
#define LLRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

@implementation UIImage (CutImage)

- (UIImage *)cutCircularImage:(UIImage *)image{
    if (image) {
        //image 存在
        CGSize imageSize = image.size;
        UIGraphicsBeginImageContext(image.size);//开启上下文 画布
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,imageSize.width,imageSize.height)];//创建路径
        [path addClip];//裁剪
        [image drawAtPoint:CGPointZero];//绘制
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();//获取图片
        UIGraphicsEndImageContext();//关闭
        return newImage;
    }
    return nil;
}


-(UIImage *)cutCircularImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth withBorderColor:(UIColor *)borderColor{
    if (image) {
        if (borderWidth < 1) {
            borderWidth = 2;
        }
        if (!borderColor) {
            borderColor = LLRGBAColor(22, 155, 255, 1.0);
        }
        CGSize imageSize = image.size;
        UIGraphicsBeginImageContext(imageSize);
        UIBezierPath * borderPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
        [borderColor set];
        [borderPath fill];
        UIBezierPath * imagePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageSize.width - 2 * borderWidth, imageSize.height - 2 * borderWidth)];
        [imagePath addClip];
        [image drawAtPoint:CGPointZero];
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    return nil;
}


@end
