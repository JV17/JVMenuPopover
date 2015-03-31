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
        _menuView.delegate = self;
    }
    
    return _menuView;
}

- (UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        UIImage *closeImg = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"cancel_filled-32"] withColor:[UIColor whiteColor]];
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(14, 28, closeImg.size.width, closeImg.size.height);
        _closeBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
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
            self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        } completion:^(BOOL finished) {
            if(finished)
            {
                // takes a screenshot of the current navigation view
                self.image = [JVMenuHelper takeScreenShotOfView:self.navController.view afterScreenUpdates:NO];
                
                // add some blur to screenshot
//                self.image = [JVMenuHelper blurryImage:_image withBlurLevel:0.2];
                
                // scale blurred image to actual controller view size
//                self.image = [JVMenuHelper imageWithImage:_image convertToSize:self.view.frame.size];
                
                // setting blurred bg image to view and preparing controller objects for animation
                self.view.backgroundColor = [UIColor colorWithPatternImage:_image];
                self.doneAnimations = YES;
                self.closeBtn.alpha = 0.0;
                self.menuView.alpha = 0.0;

                // trigger "present menu controller" animation
                [self.navController presentViewController:self
                                                 animated:NO
                                               completion:^{
                                                       [UIView animateWithDuration:0.3
                                                                             delay:0.0
                                                                           options:UIViewAnimationOptionCurveEaseIn
                                                                        animations:^{
                                                                            self.closeBtn.alpha = 1.0;
                                                                            self.menuView.alpha = 1.0;
                                                                            [self.menuView.tableView reloadData];
                                                                        } completion:nil];
                }];
            }
        }];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        self.dummyCtr = 1;
    }
}

- (void)closeMenuFromController:(UIViewController *)viewController
{
    // if we haven't finished show menu animations then return to avoid overlaps or interruptions
    if(!self.doneAnimations)
        return;
    
    if(self.dummyCtr == 1)
    {
        // resetting current visible controller scale & dimissing menu controller
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
            self.doneAnimations = NO;
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
            self.dummyCtr = 0;
            [self.navController dismissViewControllerAnimated:NO
                                                   completion:^{
                                                       [self.currentController dismissViewControllerAnimated:NO completion:nil];
                                                   }];
        }];
    }
}

#pragma mark - Delegates

- (void)menuPopover:(JVMenuPopoverView *)JVMenuPopoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(setNewViewController:fromIndexPath:)])
    {
        [self closeMenuFromController:nil];
        [self.delegate setNewViewController:self.navController fromIndexPath:indexPath];
    }
}

- (void)closeMenu
{
    if([self.delegate respondsToSelector:@selector(closeMenu:)])
    {
        [self.delegate closeMenu:self];
    }
}

@end