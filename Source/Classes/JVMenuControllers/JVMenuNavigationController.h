//
//  JVMenuNavigationController.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import <UIKit/UIKit.h>


@interface JVMenuNavigationController : UINavigationController

// properties
@property (nonatomic, assign) BOOL withTransparentNavBar; // allows hide the nav bar

// initializer
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

@end