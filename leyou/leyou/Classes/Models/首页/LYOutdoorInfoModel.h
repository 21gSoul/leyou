//
//  LYOutdoorInfoModel.h
//  leyou
//
//  Created by lu.liu on 2017/3/14.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface LYOutdoorInfoModel : AVObject<AVSubclassing>
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) AVFile *image;
@property (nonatomic, strong) NSNumber *views;
@property (nonatomic, strong) AVRelation *comments;
@end
