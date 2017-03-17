//
//  LYCommentsViewController.h
//  leyou
//
//  Created by lu.liu on 2017/3/12.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYComment.h"
@interface LYCommentsViewController : LYBaseViewController
@property (nonatomic, strong) NSArray<LYComment *> *comments;
@property (nonatomic, strong) AVRelation *relation;
@end
