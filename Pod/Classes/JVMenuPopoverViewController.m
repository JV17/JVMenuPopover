//
//  JVMenuPopoverViewController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-16.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuPopoverViewController.h"
#import <JVMenuHelper.h>

@interface JVMenuPopoverViewController ()

// Protected Properties
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UIViewController *currentController;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) CGSize screenSize;
@property (nonatomic, assign) BOOL doneAnimations;
@property (nonatomic) int dummyCtr;// TODO: remove this!
@property (nonatomic, strong) UIView *containerView;

@end

@implementation JVMenuPopoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setting up menu controller
    [self controllerSetup];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom getters & setters

- (void)controllerSetup
{
    // get main screen size
    self.screenSize = [JVMenuHelper getScreenSize];

    self.view.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.closeBtn];
    
}

- (JVMenuPopoverView *)menuView
{
    if(!_menuView)
    {
        _menuView = [[JVMenuPopoverView alloc] initWithFrame:self.view.frame];
        _menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }
    
    return _menuView;
}

- (UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(17, 29, 25, 25);
        UIImage *closeImg = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"cancel-50"] withColor:[UIColor whiteColor]];
        [_closeBtn setImage:closeImg forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeMenuFromController:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}


#pragma mark - Show & Close menu

- (void)showMenuFromController:(UIViewController *)viewController
{
    if(self.dummyCtr == 0)
    {
        // find the navigation controller and then get the current visible controller
        self.navController = (UINavigationController *)[JVMenuHelper topViewController];
//        self.currentController = self.navController.visibleViewController;
        self.currentController = viewController;
        
        [UIView animateWithDuration:0.15 animations:^{
            self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.65, 0.65);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1/3 animations:^{
                self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1/3 animations:^{
                    self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.65, 0.65);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1/3 animations:^{
                        self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            if(self)
                            {
                                self.image = [JVMenuHelper takeScreenShotOfView:self.navController.view afterScreenUpdates:NO];
                                self.view.backgroundColor = [UIColor colorWithPatternImage:_image];
                                self.doneAnimations = YES;
                                self.closeBtn.alpha = 0.0;
                                self.menuView.alpha = 0.0;

                                [self.navController presentViewController:self
                                                                 animated:NO
                                                               completion:^{
                                                                       [UIView animateWithDuration:0.5
                                                                                             delay:0.0
                                                                                           options:UIViewAnimationOptionCurveEaseIn
                                                                                        animations:^{
                                                                                            self.closeBtn.alpha = 1.0;
                                                                                            self.menuView.alpha = 1.0;
                                                                                        } completion:nil];
                                }];
                            }
                        }
                    }];
                }];
            }];
        }];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        self.dummyCtr = 1;
    }
}

- (void)closeMenuFromController:(UIViewController *)viewController
{
    if(!self.doneAnimations)
        return;
    
    if(self.dummyCtr == 1)
    {
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
                self.doneAnimations = NO;
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                self.dummyCtr = 0;
                [self.navController dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

#pragma mark - Delegates

- (void)closeMenu
{
    if([self.delegate respondsToSelector:@selector(closeMenu:)])
    {
        [self.delegate closeMenu:self];
    }
}

@end