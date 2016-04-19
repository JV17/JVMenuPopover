//
//  UIViewController+JVMenuCategory.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-18.
//
//

#import <UIKit/UIKit.h>


@interface UIViewController (JVMenuCategory)

/**
 Gets the top view controller.
 
 @return
    The top view controller.
 */
+ (UIViewController *)topViewController;


/**
 Gets the top view controller from root controller.
 
 @return
    The top view controller.
 */
+ (UIViewController *)topViewControllerWithRootController:(UIViewController *)rootViewController;

@end
