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
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) CGSize screenSize;
@property (nonatomic, assign) BOOL doneAnimations;
@property (nonatomic) int dummyCtr;// TODO: remove this!

@end

@implementation JVMenuPopoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self controllerSetup];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom getters & setters

- (void)controllerSetup
{
    // get main screen size
    self.screenSize = [JVMenuHelper getScreenSize];

    self.view.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
    self.view.backgroundColor = [UIColor clearColor];
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame = CGRectMake(10, 20, 50, 50);
    [self.closeBtn setImage:[UIImage imageNamed:@"cancel-25"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeMenuFromController:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.closeBtn];
    
}

- (JVMenuPopoverView *)menuView
{
    if(!_menuView)
    {
        _menuView = [[JVMenuPopoverView alloc] initWithFrame:self.view.frame];
        _menuView.backgroundColor = [UIColor clearColor];
    }
    
    return _menuView;
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
            self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.73, 0.73);
            //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.73, 0.73);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1/3 animations:^{
                self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1/3 animations:^{
                    self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75);
                    //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1/3 animations:^{
                        self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                        //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                    } completion:^(BOOL finished) {
                        
                        UIImage *bgImage = [JVMenuHelper captureScreenInRect:self.view.bounds ofView:self.navController.view];
                        self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
                        self.imageView = [[UIImageView alloc] initWithImage:bgImage];
                        self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);

                        if(finished)
                        {
                            self.doneAnimations = YES;
//                            if(!_tableView.window)
//                            {
//                                [self addSubview:self.tableView];
//                            }
//                            [self.navController.view addSubview:self.menuView];
                            
                            if(self)
                            {
                                [self.navController presentViewController:self animated:NO completion:nil];
                            }
                            
                            
                            // tell the delegate we are ready to show the menu
//                            if([self.delegate respondsToSelector:@selector(showMenu:inViewController:)])
//                            {
//                                [self.delegate showMenu:self inViewController:self.currentController];
//                            }
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
        if(_menuView.window)
        {
            [self.menuView performSelector:@selector(removeFromSuperview)];
            [self.closeBtn performSelector:@selector(removeFromSuperview)];
            self.view.backgroundColor = [UIColor clearColor];
            [self.view addSubview:self.imageView];
        }
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
//            self.currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            self.imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.7, 1.7);
        } completion:^(BOOL finished) {
            if(finished) // TODO: remove this or move to bottmo animation
            {
                self.doneAnimations = NO;
                [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                self.dummyCtr = 0;
                [self.imageView performSelector:@selector(removeFromSuperview)];
                [self dismissViewControllerAnimated:NO completion:nil];
            }
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