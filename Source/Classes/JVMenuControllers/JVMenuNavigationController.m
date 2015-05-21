//
//  JVMenuNavigationController.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import "JVMenuNavigationController.h"


@interface JVMenuNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

@end


@implementation JVMenuNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (!(self = [super initWithRootViewController:rootViewController]))
        return nil;
    
    // keeping track of the view controller
    // self.rootViewController = rootViewController;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
                     } completion:nil];
}


#pragma mark - Custom getters & setters

- (void)setWithTransparentNavBar:(BOOL)withTransparentNavBar
{
    _withTransparentNavBar = withTransparentNavBar;
    
    if(withTransparentNavBar)
    {
        // make the navigation bar transparent
        [self.navigationBar setBackgroundImage:[UIImage new]
                                                      forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.shadowImage = [UIImage new];
        self.navigationBar.translucent = YES;
        self.view.backgroundColor = [UIColor clearColor];
        self.navigationBar.backgroundColor = [UIColor clearColor];
    }
}

@end