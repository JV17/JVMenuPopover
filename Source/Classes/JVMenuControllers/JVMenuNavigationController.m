//
//  JVMenuNavigationController.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import "JVMenuNavigationController.h"
#import "JVMenuPushAnimator.h"
#import "JVMenuPopAnimator.h"
#import "JVMenuPopoverViewController.h"


@interface JVMenuNavigationController () <UINavigationControllerDelegate, JVMenuPopoverViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) JVMenuPopoverViewController *menuController;

@end


@implementation JVMenuNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (!(self = [super initWithRootViewController:rootViewController]))
        return nil;
    
    // keeping track of the view controller
    self.rootViewController = rootViewController;
    
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
    [UIView animateWithDuration:0.3/1.5
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // animations
                         viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     } completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
//    if (operation == UINavigationControllerOperationPush)
//    {
//        return [[JVMenuPushAnimator alloc] init];
//    }
//    else if (operation == UINavigationControllerOperationPop)
//    {
//        return [[JVMenuPopAnimator alloc] init];
//    }
    
    return nil;
}


#pragma mark - Custom getters & setters

- (JVMenuPopoverViewController *)menuController
{
    if(!_menuController)
    {
        _menuController = [[JVMenuPopoverViewController alloc] init];
        _menuController.delegate = self;
    }
    
    return _menuController;
}

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

#pragma mark - Nav Helper Functions

- (void)showMenu
{
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
//    [self.menuController.view endEditing:YES];
    
    // Present the view controller
//    [self.menuController showMenuFromController:self];
}


#pragma mark - Menu Delegate

//- (void)showMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController inViewController:(UIViewController *)viewController
//{
//    [self.navigationController presentViewController:JVMenuPopoverViewController animated:NO completion:nil];
//}

- (void)closeMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController
{
//    [self.navigationController popToViewController:JVMenuPopoverViewController animated:NO];
}

- (void)setNewViewController:(UINavigationController *)navController fromIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
//        self.mainController = [[JVMenuRootViewController alloc] init];
        //        self.mainController.transitioningDelegate = self.menuTransitions;
        //self.mainController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
//        [self setViewControllers:@[]];
    }
    else if(indexPath.row == 1)
    {
//        self.secondController = [[JVMenuSecondController alloc] init];
        //        self.mainController.transitioningDelegate = self.menuTransitions;
        //        self.secondController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
//        [self setViewControllers:@[]];
    }
    else if (indexPath.row == 2)
    {
//        self.thirdController = [[JVMenuThirdController alloc] init];
//        self.thirdController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
//        [navController setViewControllers:@[self.thirdController]];
    }
    else if (indexPath.row == 3)
    {
//        self.fourthController = [[JVMenuFourthController alloc] init];
//        self.fourthController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
//        [navController setViewControllers:@[self.fourthController]];
    }
    else if (indexPath.row == 4)
    {
//        self.fifthController = [[JVMenuFifthController alloc] init];
//        self.fifthController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
//        [navController setViewControllers:@[self.fifthController]];
    }
}

@end