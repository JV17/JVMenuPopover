//
//  JVMenuNavigationController.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import "JVMenuNavigationController.h"


@implementation JVMenuNavigationController

#pragma mark - Lifecycle

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController transparentNavBar:(BOOL)transparentNavBar
{
    self = [super initWithRootViewController:rootViewController];
    
    if (self)
    {
        // initializer
        _withTransparentNavBar = transparentNavBar;
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTransparentNavBar];
    self.delegate = self;
}


#pragma mark - UINavigationController delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // perparing view controller before display
    viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
    
    // presenting view controller animations
    [UIView animateWithDuration:0.2
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // animations
                         viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }
                     completion:nil];
}


#pragma mark - Custom Accessors

- (void)setWithTransparentNavBar:(BOOL)withTransparentNavBar
{
    _withTransparentNavBar = withTransparentNavBar;
    
    [self setTransparentNavBar];
}


- (void)setTransparentNavBar
{
    if(self.withTransparentNavBar)
    {
        // make the navigation bar transparent
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage new];
        self.navigationBar.translucent = YES;
        self.view.backgroundColor = [UIColor clearColor];
        self.navigationBar.backgroundColor = [UIColor clearColor];
    }
}

@end
