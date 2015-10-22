//
//  JVMenuPopoverViewController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-16.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuPopoverViewController.h"
#import "UIImage+JVMenuCategory.h"
#import "UIViewController+JVMenuCategory.h"


@interface JVMenuPopoverViewController ()

@property (nonatomic, strong) UIViewController *viewController;

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

#pragma mark - Lifecycle

- (instancetype)initWithImages:(NSArray *)images titles:(NSArray *)titles closeImage:(UIImage *)closeImage
{
    if(!(self = [super init]))
        return nil;
    
    // storing images, titles and close image for display
    self.images = images;
    self.titles = titles;
    self.closeImage = closeImage;
    
    // checking if we have images or title for display
    if(self.images.count == 0 || self.titles.count == 0 || !self.closeImage)
    {
        NSLog(@"Initializing JVMenuPopoverViewController without images, title or close image may result on an empty menu.");
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setting up menu controller
    [self controllerSetup];
    
}


- (void)controllerSetup
{
    // get main screen size
    self.screenSize = [UIScreen mainScreen].bounds.size;
    
    self.view.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
    self.view.backgroundColor = [UIColor clearColor];
    
    // since we will be adding these later we need to create them to have them ready before hand
    //    self.menuView = [self menuView];
    //    self.closeBtn = [self closeBtn];
    
    // setting menu view animations
    self.menuView.slideInAnimation = self.slideInAnimation;
    self.menuView.slideInWithBounceAnimation = self.slideInWithBounceAnimation;
    
    // adding menu view and close button
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.closeBtn];
    
}


#pragma mark - Custom Accessors



- (UIImage *)image
{
    return [UIImage takeScreenShotOfView:self.viewController.view afterScreenUpdates:NO];
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


- (JVMenuNavigationController *)navController
{
    if (!_navController)
    {
        _navController = (JVMenuNavigationController *)[UIViewController topViewController];
    }
    
    return _navController;
}


#pragma mark - Show & Close menu

- (void)showMenuFromController:(UIViewController *)viewController
{
    if(self.doneAnimations)
    {
        return;
    }

    self.currentController = viewController;
    
//    [viewController addChildViewController:self];
//    [viewController.view addSubview:self.view];
//    [self didMoveToParentViewController:viewController];
    
//     self.currentController = self.rootController.visibleViewController;
//    self.currentController = viewController;
    
    // spring animations
    [UIView animateWithDuration:0.15
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // animation
                         self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
//                         self.currentController.view.frame = CGRectMake(30, 100, 300, 500);
//                         self.currentController.view.clipsToBounds = YES;
    } completion:^(BOOL finished) {
        if(!finished)
        {
            return;
        }
        
        // setting blurred bg image to view and preparing controller objects for animation
        self.view.backgroundColor = [UIColor colorWithPatternImage:self.image];
        
        //only apply the blur if the user hasn't disabled transparency effects
        if(!UIAccessibilityIsReduceTransparencyEnabled())
        {
            // uncomment for vibrance effect
            // [self.vibrancyEffectView.contentView addSubview:self.menuView];
            // [self.vibrancyEffectView.contentView addSubview:self.closeBtn];
            // [self.blurEffectView.contentView addSubview:self.vibrancyEffectView];
            // [self.view addSubview:self.blurEffectView];
            [self.view insertSubview:self.blurEffectView atIndex:0];
        }
        
        self.doneAnimations = YES;
        self.closeBtn.alpha = 0.0;
        self.menuView.alpha = 0.0;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.view];

        // trigger "present menu controller" animation
//        [self.currentController.navigationController presentViewController:self
//                                          animated:NO
//                                        completion:^{
                                        [UIView animateWithDuration:0.15
                                                              delay:0.0
                                                            options:UIViewAnimationOptionCurveEaseInOut
                                                         animations:^{
                                                            self.closeBtn.alpha = 1.0;
                                                            self.menuView.alpha = 1.0;
                                                            [self.menuView.tableView reloadData];
                                                        } completion:nil];
        }];
//    }];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}


- (void)closeMenuFromController:(UIViewController *)viewController
{
    // if we haven't finished show menu animations then return to avoid overlaps or interruptions
    if(!self.doneAnimations)
    {
        return;
    }

    [self.view removeFromSuperview];

    // resetting current visible controller scale & dimissing menu controller
    [UIView animateWithDuration:0.3/1.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // animations
                         self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     } completion:^(BOOL finished) {
                         // completion
                         self.doneAnimations = NO;
                         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//                         [self.navController dismissViewControllerAnimated:NO
//                                                                 completion:^{
//                                                                     [self dismissViewControllerAnimated:NO completion:nil];
//                                                                 }];
    }];
}


#pragma mark - Delegates

- (void)menuPopoverDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(setNewViewControllerWithIndexPath:)])
    {
        [self.view removeFromSuperview];
//        [self closeMenuFromController:self.viewController];
        [self.delegate setNewViewControllerWithIndexPath:indexPath];
  }
}


- (void)closeMenu
{
    if([self.delegate respondsToSelector:@selector(closeMenu:)])
    {
        [self.view removeFromSuperview];
//        [self.delegate closeMenu:self];
    }
}

@end