//
//  LYCommentTableViewCell.h
//  leyou
//
//  Created by lu.liu on 2017/3/12.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYComment.h"
#import "LYReply.h"
@interface LYCommentTableViewCell : UITableViewCell
@property (nonatomic, strong) LYComment *model;
@property (nonatomic, strong) NSArray<LYReply *> *replies;
@end
