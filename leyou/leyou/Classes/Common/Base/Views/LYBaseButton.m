//
//  LYLikeButton.m
//  leyou
//
//  Created by lu.liu on 2017/3/16.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYBaseButton.h"
@interface LYBaseButton()
@property (nonatomic, copy) ActionBlock action;
@end
@implementation LYBaseButton
- (instancetype)initWithAction:(ActionBlock)action
{
    self = [super init];
    if (self) {
        _action = action;
        [self addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)didClick{
    
//    UIViewAnimationOptions op = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionBeginFromCurrentState;
//    [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
//        self.likeImageView.layer.affineTransform = CGAffineTransformMakeScale(0.97, 0.97);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
//            self.likeImageView.layer.affineTransform = CGAffineTransformMakeScale(1.008, 1.008);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.1 delay:0 options:op animations:^{
//                self.likeImageView.layer.affineTransform = CGAffineTransformMakeScale(1, 1);
//            } completion:^(BOOL finished) {
//            }];
//        }];
//    }];

    if (_action) {
        _action();
    }
    
}

@end
