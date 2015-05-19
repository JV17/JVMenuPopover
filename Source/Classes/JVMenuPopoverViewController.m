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

@property (nonatomic, strong) UIBlurEffect *blurEffect;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;
@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;

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
    
//    self.menuView = [self menuView];
//    self.closeBtn = [self closeBtn];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.closeBtn];
    
}

- (JVMenuPopoverView *)menuView
{
    if(!_menuView)
    {
        _menuView = [[JVMenuPopoverView alloc] initWithFrame:self.view.frame];
        _menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _menuView.delegate = self;
    }
    
    return _menuView;
}

- (UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        UIImage *closeImg = [UIImage imageNamed:@"cancel_filled-50"];
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(15, 28, closeImg.size.width, closeImg.size.height);
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setImage:closeImg forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeMenuFromController:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}

- (UIBlurEffect *)blurEffect
{
    if(!_blurEffect)
    {
        _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    
    return _blurEffect;
}

- (UIVisualEffectView *)blurEffectView
{
    if(!_blurEffectView)
    {
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
        _blurEffectView.alpha = 0.6;
        _blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _blurEffectView.frame = self.view.frame;
    }
    
    return _blurEffectView;
}

- (UIVibrancyEffect *)vibrancyEffect
{
    if(!_vibrancyEffect)
    {
        _vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:self.blurEffect];
    }
    
    return _vibrancyEffect;
}

- (UIVisualEffectView *)vibrancyEffectView
{
    if(!_vibrancyEffectView)
    {
        _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:self.vibrancyEffect];
        _vibrancyEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _vibrancyEffectView.frame = self.view.frame;
    }
    
    return _vibrancyEffectView;
}

#pragma mark - Show & Close menu

- (void)showMenuFromController:(UIViewController *)viewController
{
    if(self.doneAnimations)
        return;
    
    // find the navigation controller and then get the current visible controller
    self.navController = (UINavigationController *)[JVMenuHelper topViewController];
    // self.currentController = self.navController.visibleViewController;
    self.currentController = viewController;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
    } completion:^(BOOL finished) {
        if(finished)
        {
            // takes a screenshot of the current navigation view
            self.image = [JVMenuHelper takeScreenShotOfView:self.navController.view afterScreenUpdates:NO];
            
            // setting blurred bg image to view and preparing controller objects for animation
            self.view.backgroundColor = [UIColor colorWithPatternImage:self.image];
            
            //only apply the blur if the user hasn't disabled transparency effects
            if(UIAccessibilityIsReduceTransparencyEnabled != NULL) {
                if(!UIAccessibilityIsReduceTransparencyEnabled())
                {
                    // uncomment for vibrance effect
                    // [self.vibrancyEffectView.contentView addSubview:self.menuView];
                    // [self.vibrancyEffectView.contentView addSubview:self.closeBtn];
                    // [self.blurEffectView.contentView addSubview:self.vibrancyEffectView];
                    // [self.view addSubview:self.blurEffectView];
                    [self.view insertSubview:self.blurEffectView atIndex:0];
                }
            }
            
            self.doneAnimations = YES;
            self.closeBtn.alpha = 0.0;
            self.menuView.alpha = 0.0;

            // trigger "present menu controller" animation
            [self.navController presentViewController:self
                                             animated:NO
                                           completion:^{
                                                   [UIView animateWithDuration:0.15
                                                                         delay:0.0
                                                                       options:UIViewAnimationOptionCurveEaseInOut
                                                                    animations:^{
                                                                        self.closeBtn.alpha = 1.0;
                                                                        self.menuView.alpha = 1.0;
                                                                        [self.menuView.tableView reloadData];
                                                                    } completion:nil];
            }];
        }
    }];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)closeMenuFromController:(UIViewController *)viewController
{
    // if we haven't finished show menu animations then return to avoid overlaps or interruptions
    if(!self.doneAnimations)
        return;
    
    // resetting current visible controller scale & dimissing menu controller
    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    } completion:^(BOOL finished) {
        self.doneAnimations = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navController dismissViewControllerAnimated:NO
                                               completion:^{
                                                   [self.currentController dismissViewControllerAnimated:NO completion:nil];
                                               }];
    }];
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