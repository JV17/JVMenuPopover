//
//  JVMenuNavigationController.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import <UIKit/UIKit.h>


@interface JVMenuNavigationController : UINavigationController

@property (nonatomic, assign) BOOL withTransparentNavBar;

// initializer
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

@end