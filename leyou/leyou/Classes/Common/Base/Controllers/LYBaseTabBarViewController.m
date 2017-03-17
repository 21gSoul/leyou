//
//  LYBaseTabBarViewController.m
//  leyou
//
//  Created by lu.liu on 2017/3/9.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYBaseTabBarViewController.h"
#import "LYHomePageViewController.h"
#import "LYActivityViewController.h"
#import "LYNearbyViewController.h"
#import "LYMyViewController.h"
@interface LYBaseTabBarViewController ()

@end

@implementation LYBaseTabBarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    
    NSArray *selectedImages;
    NSArray *normalImages;
    NSArray *vcClasses = @[@"LYHomePageViewController",@"LYNearbyViewController",@"LYActivityViewController",@"LYMyViewController"];
    NSArray *titles = @[@"首页",@"周边",@"活动",@"我的"];
    normalImages = @[@"首页_gary",@"周边_gary",@"活动_gary",@"我的_gary"];
        selectedImages = @[@"首页_blue",@"周边_blue",@"活动_blue",@"我的_blue"];
   
    NSMutableArray *vcs = [@[] mutableCopy];
    for (int i = 0; i < 4; i++) {
        UIViewController *vc = [self viewControllerWithName:vcClasses[i] normalImage:[UIImage imageNamed:normalImages[i]] selectedImage:[UIImage imageNamed:selectedImages[i]] title:titles[i]];
        [vcs addObject:vc];
    }
    
    self.viewControllers = vcs;
}


- (UIViewController *)viewControllerWithName:(NSString *)name normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    UIViewController *vc = [[NSClassFromString(name) alloc] init];
    vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage =[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}



@end
