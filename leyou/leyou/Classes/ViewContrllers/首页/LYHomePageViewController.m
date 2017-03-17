//
//  LYHomePageViewController.m
//  leyou
//
//  Created by lu.liu on 2017/3/9.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYOutdoorInfoViewController.h"
#import "UIColor+DefaultColor.h"
#import "CommonMarco.h"
@interface LYHomePageViewController ()

@end

@implementation LYHomePageViewController

#pragma mark - init -
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupViewControllers];
    }
    return self;
}

#pragma mark - Life -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setupViewControllers{
    Class cls = [LYOutdoorInfoViewController class];
    self.viewControllerClasses = @[cls,cls,cls,cls,cls,cls];
    self.titles = @[@"钓鱼",@"爬山",@"露营",@"骑行",@"野炊",@"徒步"];
    self.keys = [@[@"outdoorType",@"outdoorType",@"outdoorType",
                   @"outdoorType",@"outdoorType",@"outdoorType"] mutableCopy];
    self.values = [self.titles mutableCopy];
    self.titleColorSelected = [UIColor getMainColor];
    self.titleColorNormal = [UIColor getMainTextColor];
    self.menuHeight = 40 * kSCREEN_HRATE;
    self.menuViewStyle = WMMenuViewStyleLine;
}




@end
