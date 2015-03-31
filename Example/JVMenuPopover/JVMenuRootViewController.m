//
//  JVMenuRootViewController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 03/14/2015.
//  Copyright (c) 2014 Jorge Valbuena. All rights reserved.
//

#import "JVMenuRootViewController.h"
#import "JVMenuSecondController.h"
#import "JVMenuThirdController.h"
#import "JVMenuFourthController.h"
#import "JVMenuFifthController.h"


@interface JVMenuRootViewController ()

@property (nonatomic, strong) UIImage *menuImg;
@property (nonatomic, strong) JVMenuPopoverViewController *menuController;

// view controllers
@property (nonatomic, strong) JVMenuRootViewController *mainController;
@property (nonatomic, strong) JVMenuSecondController *secondController;
@property (nonatomic, strong) JVMenuThirdController *thirdController;
@property (nonatomic, strong) JVMenuFourthController *fourthController;
@property (nonatomic, strong) JVMenuFifthController *fifthController;

@end

@implementation JVMenuRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // gradient background color
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.frame;
    UIColor *firstColor = [UIColor colorWithRed:0.1126f
                                          green:0.8152f
                                           blue:0.0622f
                                          alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:0.0826f
                                           green:0.5152f
                                            blue:0.0322f
                                           alpha:1.0f];
    
    gradient.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    self.menuImg = [UIImage imageNamed:@"menu-26"];
    
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"home-32"] withColor:[UIColor blackColor]];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.image.size.width/2, self.view.frame.size.height/2-40, self.image.size.width, self.image.size.height)];
    [self.imageView setImage:self.image];
    
    [self.view addSubview:self.imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-110, self.view.frame.size.height/2-20, 220, 60)];
    self.label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.label.textColor = [UIColor blackColor];
    self.label.text = @"Home";

    [self.view addSubview:self.label];
    
    self.menuController = [self menuController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.menuImg style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    // make the navigation bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Navigation helper functions

- (void)showMenu
{
    [self.menuController showMenuFromController:self];
}

#pragma mark - Menu Delegate

//- (void)showMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController inViewController:(UIViewController *)viewController
//{
//    [self.navigationController presentViewController:JVMenuPopoverViewController animated:NO completion:nil];
//}

- (void)closeMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController
{
    [self.navigationController popToViewController:JVMenuPopoverViewController animated:NO];
}

- (void)setNewViewController:(UINavigationController *)navController fromIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        self.mainController = [[JVMenuRootViewController alloc] init];
        self.mainController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        [navController setViewControllers:@[self.mainController]];
    }
    else if(indexPath.row == 1)
    {
        self.secondController = [[JVMenuSecondController alloc] init];
        self.secondController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        [navController setViewControllers:@[self.secondController]];
    }
    else if (indexPath.row == 2)
    {
        self.thirdController = [[JVMenuThirdController alloc] init];
        self.thirdController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        [navController setViewControllers:@[self.thirdController]];
    }
    else if (indexPath.row == 3)
    {
        self.fourthController = [[JVMenuFourthController alloc] init];
        self.fourthController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        [navController setViewControllers:@[self.fourthController]];
    }
    else if (indexPath.row == 4)
    {
        self.fifthController = [[JVMenuFifthController alloc] init];
        self.fifthController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        [navController setViewControllers:@[self.fifthController]];
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [UIView animateWithDuration:0.3/1.5 animations:^{
        viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    } completion:nil];
}

@end
