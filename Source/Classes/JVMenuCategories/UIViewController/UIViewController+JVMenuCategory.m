//
//  UIViewController+JVMenuCategory.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-18.
//
//

#import "UIViewController+JVMenuCategory.h"


@implementation UIViewController (JVMenuCategory)

+ (UIViewController *)topViewController
{
    return [self topViewControllerWithRootController:[UIApplication sharedApplication].keyWindow.rootViewController.navigationController];
}


+ (UIViewController *)topViewControllerWithRootController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil)
    {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self topViewControllerWithRootController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    
    return [self topViewControllerWithRootController:presentedViewController];
}

@end
