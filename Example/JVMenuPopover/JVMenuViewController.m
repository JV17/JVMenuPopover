//
//  JVMenuViewController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 03/14/2015.
//  Copyright (c) 2014 Jorge Valbuena. All rights reserved.
//

#import "JVMenuViewController.h"

@interface JVMenuViewController ()
@property (nonatomic) int dummyCtr;
@property (nonatomic, strong) UIImage *menuImg;
@end

@implementation JVMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.menuImg = [UIImage imageNamed:@"menu-26"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-60, self.view.frame.size.height/2-20, 120, 40)];
    label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:22];
    label.textColor = [UIColor blackColor];
    label.text = @"JVMenu!";

    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self == [self.navigationController.viewControllers firstObject])
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.menuImg style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    // make the navigation bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}


#pragma mark - show menu

- (void)showMenu
{
    if(self.dummyCtr == 0)
    {
        [UIView animateWithDuration:0.15 animations:^{
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.73, 0.73);
//            self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.73, 0.73);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1/3 animations:^{
                self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
//                self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1/3 animations:^{
                    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75);
//                    self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1/3 animations:^{
                        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
//                        self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                    }];
                }];
            }];
        }];

        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        self.dummyCtr = 1;
    }
    else
    {
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2/4 animations:^{
//                self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15/4 animations:^{
//                    self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.15/4 animations:^{
//                        self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                    }];
                }];
            }];
        }];
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        self.dummyCtr = 0;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
