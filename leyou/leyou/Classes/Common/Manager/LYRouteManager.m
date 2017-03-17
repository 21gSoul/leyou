

#import "LYRouteManager.h"

@implementation LYRouteManager

+ (instancetype)shareManager{
    static LYRouteManager *once;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        once = [LYRouteManager new];
    });
    return once;
}


- (UIViewController *)currentViewController {
    UIViewController *resultViewController;
    resultViewController = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultViewController.presentedViewController) {
        resultViewController = [self topViewController:resultViewController.presentedViewController];
    }
    return resultViewController;
}

- (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (void)pushViewController:(UIViewController *)vc {
    UIViewController *currentViewController = [self currentViewController];
    
    if ([currentViewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController*)currentViewController pushViewController:vc animated:YES];
        return;
    }
    
    if (currentViewController.navigationController) {
        [currentViewController.navigationController pushViewController:vc animated:YES];
        return;
    }
}

- (void)presentViewController:(UIViewController *)vc{
    
    UIViewController *currentViewController = [self currentViewController];
    
    if (currentViewController) {
        [currentViewController presentViewController:vc animated:YES completion:nil];
    }
    
}

@end
