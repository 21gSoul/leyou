//
//  LYLikeButton.h
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ActionBlock)();
@interface LYBaseButton : UIButton
- (instancetype)initWithAction:(ActionBlock)action;
@end
