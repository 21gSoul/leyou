//
//  LYUser.h
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface LYUser : AVUser<AVSubclassing>

@property (nonatomic, strong) AVFile *headImage;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *brithday;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) AVRelation *comments;
@property (nonatomic, strong) AVRelation *replies;
@property (nonatomic, strong) AVRelation *activties;
@property (nonatomic, strong) AVRelation *collect;
@property (nonatomic, copy) NSString *like;

@end
