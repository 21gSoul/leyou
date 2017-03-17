//
//  LYModelSetting.h
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYModelSetting : NSObject
+ (instancetype)shareModelSetting;
- (void)registerClass;
@end
