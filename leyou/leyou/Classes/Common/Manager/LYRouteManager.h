//
//  MSRouteHandler.h
//  MSRouteDemo
//
//  Created by jsfu on 2017/1/24.
//  Copyright © 2017年 MaShang Consumer Finance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LRM [LYRouteManager shareManager]
@interface LYRouteManager : NSObject

+ (instancetype)shareManager;

- (UIViewController*)currentViewController;

- (void)pushViewController:(UIViewController *)vc;

- (void)presentViewController:(UIViewController *)vc;
@end
