//
//  JVMenuNavigationController.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import <UIKit/UIKit.h>


@interface JVMenuNavigationController : UINavigationController <UINavigationControllerDelegate>

/** Allows hide the nav bar. */
@property (nonatomic, assign, readwrite) BOOL withTransparentNavBar;


/**
 Custom initializer for the JVMenuNavigationController with a rootViewController.
 
 @param rootViewController
    The UIViewController type to be set as the root controller of our navigation.
 @param transparentNavBar
    Tells if you want to hide the navigation bar.

 @return
    The initialized JVMenuNavigationController with specified root controller.
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController transparentNavBar:(BOOL)transparentNavBar;

@end