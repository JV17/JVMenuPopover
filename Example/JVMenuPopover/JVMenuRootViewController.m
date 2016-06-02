//
//  JVMenuRootViewController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 03/14/2015.
//  Copyright (c) 2014 Jorge Valbuena. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "JVMenuRootViewController.h"
#import "JVMenuSecondController.h"
#import "JVMenuThirdController.h"
#import "JVMenuFourthController.h"
#import "JVMenuFifthController.h"


@interface JVMenuRootViewController () <UINavigationControllerDelegate, JVMenuPopoverDelegate>

@property (nonatomic, strong) JVMenuPopoverView *menuPopover;

@property (nonatomic, strong) JVMenuItems *menuItems;

@property (nonatomic, strong) CAGradientLayer *gradient;

@property (nonatomic, strong) JVMenuRootViewController *rootController;

@property (nonatomic, strong) JVMenuSecondController *secondController;

@property (nonatomic, strong) JVMenuThirdController *thirdController;

@property (nonatomic, strong) JVMenuFourthController *fourthController;

@property (nonatomic, strong) JVMenuFifthController *fifthController;


@end


@implementation JVMenuRootViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setting up controllers
    [self commonInit];
}


- (void)commonInit
{
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:self.label];
    
    [self.view addSubview:self.containerView];
    
    // creating menu
    self.menuPopover = [self menuPopover];
    
    // setting up menu bar button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_black-48"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    [self showNavigationItem];
    
    [self addObservers];
}


#pragma mark - Navigation Setup

- (void)showNavigationItem
{
    // showing the menu bar button
    [self animateNavigationItemToColor:[UIColor blackColor]];
}


- (void)hideNavigationItem
{
    // clearing up menu bar button
    [self animateNavigationItemToColor:[UIColor clearColor]];
}


- (void)animateNavigationItemToColor:(UIColor *)toColor
{
    [UIView animateWithDuration:0.15
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         self.navigationItem.leftBarButtonItem.tintColor = toColor;
                     }
                     completion:nil];
}


#pragma mark - Custom Accessors

- (JVMenuItems *)menuItems
{
    if(!_menuItems)
    {
        _menuItems = [[JVMenuItems alloc] initWithMenuImages:@[[UIImage imageNamed:@"home-48"],
                                                               [UIImage imageNamed:@"about-48"],
                                                               [UIImage imageNamed:@"settings-48"],
                                                               [UIImage imageNamed:@"business_contact-48"],
                                                               [UIImage imageNamed:@"ask_question-48"]]
                                                  menuTitles:@[@"Home",
                                                               @"About Us",
                                                               @"Our Service",
                                                               @"Contact Us",
                                                               @"Help?"]
                                        menuCloseButtonImage:[UIImage imageNamed:@"cancel_filled-50"]];
        _menuItems.menuSlideInAnimation = YES; 
    }
    
    return _menuItems;
}


- (JVMenuPopoverView *)menuPopover
{
    if(!_menuPopover)
    {
        _menuPopover = [[JVMenuPopoverView alloc] initWithFrame:self.view.frame menuItems:self.menuItems];
        _menuPopover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _menuPopover.delegate = self;
    }
    
    return _menuPopover;
}


- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc] initWithFrame:self.containerViewFrame];
        UIColor *firstColor = [UIColor colorWithHexString:@"52EDC7"];
        UIColor *secondColor = [UIColor colorWithHexString:@"5AC8FB"];
        [_containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
    }
    
    return _containerView;
}


- (CGRect)containerViewFrame
{
    return CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        _imageView.frame = self.imageViewFrame;
    }
    
    return _imageView;
}


- (CGRect)imageViewFrame
{
    return CGRectMake(self.view.frame.size.width/2-self.image.size.width/2, self.view.frame.size.height/2-30, self.image.size.width, self.image.size.height);
}


- (UIImage *)image
{
    if (!_image)
    {
        _image = [[UIImage imageNamed:@"home-48"] changeImageColor:[UIColor blackColor]];
    }
                  
    return _image;
}


- (UILabel *)label
{
    if (!_label)
    {
        _label = [[UILabel alloc] initWithFrame:self.labelFrame];
        _label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        _label.textColor = [UIColor blackColor];
        _label.text = @"Home";
    }
    
    return _label;
}


- (CGRect)labelFrame
{
    return CGRectMake(self.view.frame.size.width/2-110, self.view.frame.size.height/2-20, 220, 60);
}


- (JVMenuRootViewController *)rootController
{
    if (!_rootController)
    {
        _rootController = [[JVMenuRootViewController alloc] init];
    }
    
    return _rootController;
}


- (JVMenuSecondController *)secondController
{
    if (!_secondController)
    {
        _secondController = [[JVMenuSecondController alloc] init];
    }
    
    return _secondController;
}


- (JVMenuThirdController *)thirdController
{
    if (!_thirdController)
    {
        _thirdController = [[JVMenuThirdController alloc] init];
    }
    
    return _thirdController;
}


- (JVMenuFourthController *)fourthController
{
    if (!_fourthController)
    {
        _fourthController = [[JVMenuFourthController alloc] init];
    }
    
    return _fourthController;
}


- (JVMenuFifthController *)fifthController
{
    if (!_fifthController)
    {
        _fifthController = [[JVMenuFifthController alloc] init];
    }
    
    return _fifthController;
}


#pragma mark - Menu Helper Functions

- (void)showMenu
{
    [self.menuPopover showMenuWithController:self];
}


#pragma mark - Menu Delegate

- (void)menuPopoverDidSelectViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        self.navigationController.viewControllers = @[self.rootController];
    }
    else if(indexPath.row == 1)
    {
        self.navigationController.viewControllers = @[self.secondController];
    }
    else if (indexPath.row == 2)
    {
        self.navigationController.viewControllers = @[self.thirdController];
    }
    else if (indexPath.row == 3)
    {
        self.navigationController.viewControllers = @[self.fourthController];
    }
    else if (indexPath.row == 4)
    {
        self.navigationController.viewControllers = @[self.fifthController];
    }
}


- (void)menuPopoverViewWillShow
{
    // hiding the navigation item
    [self hideNavigationItem];
}


- (void)menuPopoverViewWillHide
{
    // showing the navigation item
    [self showNavigationItem];
}


#pragma mark - Observers

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}


- (void)didDeviceOrientationChange:(NSNotification *)notification
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    self.containerView.frame = self.containerViewFrame;
    UIColor *firstColor = [UIColor colorWithHexString:@"52EDC7"];
    UIColor *secondColor = [UIColor colorWithHexString:@"5AC8FB"];
    [self.containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];

    self.imageView.frame = self.imageViewFrame;
    self.label.frame = self.labelFrame;
}


#warning If you are using an older target OS version use this function, else remove it and use below!
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration NS_DEPRECATED_IOS(2_0,8_0, "Implement viewWillTransitionToSize:withTransitionCoordinator: instead") __TVOS_PROHIBITED
{
    if (!self.menuPopover.isHidden)
    {
        [self.menuPopover closeMenu];
    }
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    if (!self.menuPopover.isHidden)
    {
        [self.menuPopover closeMenu];
    }
}

@end
