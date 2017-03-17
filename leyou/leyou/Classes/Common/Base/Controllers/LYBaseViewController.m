//
//  LYBaseViewController.m
//  leyou
//
//  Created by lu.liu on 2017/3/7.
//  Copyright © 2017年 lu.liu. All rights reserved.
//

#import "LYBaseViewController.h"

@interface LYBaseViewController ()
@end

@implementation LYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.8];
    [self setupLeftBarButtonItem];
    [self setupDataSources];
    [self setupViews];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setupNavgationBarHeight{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0 &&[[UIDevice currentDevice].systemVersion floatValue] > 6.9 ) {
        
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}
- (void)setupViews{
    
}

- (void)setupDataSources{
    
}

- (void)loadDataSources{
}

-(void)setupLeftBarButtonItem {
    if (![self hasLeftBarButtonItem]) {
        return;
    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (BOOL)hasLeftBarButtonItem {
    return self.navigationController.viewControllers.count > 1;
}

- (void)returnAction {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0 && [[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        [self.navigationController popViewControllerAnimated:NO];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - DZNEmptyDataSetSource & DZNEmptyDataSetDelegate -

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if ([GLobalRealReachability currentReachabilityStatus] == RealStatusNotReachable) {
        return [UIImage imageNamed:@"no_internet.jpeg"];
    }else{
        if (self.isLoading) {
            NSLog(@"----");
            return [UIImage imageNamed:@"loading_imgBlue_78x78"];
        }else{
            return [UIImage imageNamed:@"empty_set.jpeg"];
        }
    }
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *title = nil;
    if ([GLobalRealReachability currentReachabilityStatus] == RealStatusNotReachable) {
        title = @"网络连接断开";
    }else{
        title = @"没有数据了";
    }
    NSDictionary *dic = @{NSFontAttributeName:[UIFont getTitleFont],NSForegroundColorAttributeName:[UIColor getTitleColor]};
    NSAttributedString *aTitle = [[NSAttributedString alloc] initWithString:title attributes:dic];
    return aTitle;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *title = nil;
    if ([GLobalRealReachability currentReachabilityStatus] == RealStatusNotReachable) {
        title = @"请检查您的网络，到设置打开网络或者检查应用是否有权限使用网络";
    }else{
        title = @"很抱歉，该模块没有更多的数据啦~";
    }
    NSDictionary *dic = @{NSFontAttributeName:[UIFont getSubFont],NSForegroundColorAttributeName:[UIColor getSubTextColor]};
    NSAttributedString *aTitle = [[NSAttributedString alloc] initWithString:title attributes:dic];
    return aTitle;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if ([GLobalRealReachability currentReachabilityStatus] != RealStatusNotReachable) {
        NSString *title = @"刷新";
        NSDictionary *dic = @{NSFontAttributeName:[UIFont getTitleFont],NSForegroundColorAttributeName:[UIColor getMainColor]};
        NSAttributedString *aTitle = [[NSAttributedString alloc] initWithString:title attributes:dic];
        return aTitle;
    }
    return nil;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    if ([GLobalRealReachability currentReachabilityStatus] != RealStatusNotReachable) {
        self.loading = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.loading = NO;
        });
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if ([GLobalRealReachability currentReachabilityStatus] != RealStatusNotReachable) {
         NSLog(@"点击重新加载按钮");
        [self loadDataSources];
    }
}

- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    
    _loading = loading;
}


@end
