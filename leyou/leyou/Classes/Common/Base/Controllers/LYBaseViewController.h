//
//  LYBaseViewController.h
//  leyou
//
//  Created by lu.liu on 2017/3/7.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "CommonMarco.h"
#import "UIColor+DefaultColor.h"
#import "UIFont+DefaultFont.h"
#import "UIControl+YYAdd.h"
#import "RealReachability.h"
#import <UIScrollView+EmptyDataSet.h>
#import <AVOSCloud.h>
@interface LYBaseViewController : UIViewController <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign, getter=isLoading) BOOL loading;
- (void)setupNavgationBarHeight;

- (void)setupDataSources;

- (void)setupViews;

- (void)loadDataSources;

@end
