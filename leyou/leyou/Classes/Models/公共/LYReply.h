//
//  LYReply.h
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "LYUser.h"
@interface LYReply : AVObject <AVSubclassing>

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSString *likes;
@property (nonatomic, strong) LYUser *user;

@end
