
//
//  LYModelSetting.m
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYModelSetting.h"
#import "LYOutdoorInfoModel.h"
#import "LYComment.h"
#import "LYUser.h"
#import "LYReply.h"
@implementation LYModelSetting

+ (instancetype)shareModelSetting{
    static LYModelSetting *once;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        once = [LYModelSetting new];
    });
    return once;
}

- (void)registerClass{
    [LYOutdoorInfoModel registerSubclass];
    [LYComment registerSubclass];
    [LYUser registerSubclass];
    [LYReply registerSubclass];
}
@end
