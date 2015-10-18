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


@interface JVMenuRootViewController () <UINavigationControllerDelegate, JVMenuPopoverViewControllerDelegate>

@property (nonatomic, strong) JVMenuPopoverViewController *menuController;

@property (nonatomic, strong) CAGradientLayer *gradient;

@property (nonatomic, strong) JVMenuSecondController *secondController;

@property (nonatomic, strong) JVMenuThirdController *thirdController;

@property (nonatomic, strong) JVMenuFourthController *fourthController;

@property (nonatomic, strong) JVMenuFifthController *fifthController;


@end


@implementation JVMenuRootViewController

#pragma mark - Lifecycle

- (instancetype)initWithMenuImage:(UIImage *)menuImage
{
    self = [super init];
    
    if (self)
    {
        _menuImg = menuImage;
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setting up controllers
    [self commonInit];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // setting up menu bar button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.menuImg style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
}


- (void)commonInit
{
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.containerView addSubview:self.imageView];
    [self.containerView addSubview:self.label];
    
    [self.view addSubview:self.containerView];
    
    // creating menu controller
    self.menuController = [self menuController];
}


#pragma mark - Custom getters & setters

- (JVMenuPopoverViewController *)menuController
{
    if(!_menuController)
    {
        _menuController = [[JVMenuPopoverViewController alloc] initWithImages:@[[UIImage imageNamed:@"home-48"],
                                                                                [UIImage imageNamed:@"about-48"],
                                                                                [UIImage imageNamed:@"settings-48"],
                                                                                [UIImage imageNamed:@"business_contact-48"],
                                                                                [UIImage imageNamed:@"ask_question-48"]]
                                                                       titles:@[@"Home",
                                                                                @"About Us",
                                                                                @"Our Service",
                                                                                @"Contact Us",
                                                                                @"Help?"]
                                                                   closeImage:[UIImage imageNamed:@"cancel_filled-50"]];
        _menuController.delegate = self;
        _menuController.slideInAnimation = YES; // choose our animation type
    }
    
    return _menuController;
}


- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc] initWithFrame:self.view.frame];
        
        UIColor *firstColor = [UIColor colorWithHexString:@"52EDC7"];
        UIColor *secondColor = [UIColor colorWithHexString:@"5AC8FB"];
        
        // setting up new gradient colors
        [_containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
    }
    
    return _containerView;
}


- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithImage:self.image];
        _imageView.frame = CGRectMake(self.view.frame.size.width/2-self.image.size.width/2, self.view.frame.size.height/2-30, self.image.size.width, self.image.size.height);
    }
    
    return _imageView;
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
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-110, self.view.frame.size.height/2-20, 220, 60)];
        _label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        _label.textColor = [UIColor blackColor];
        _label.text = @"Home";
    }
    
    return _label;
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


#pragma mark - Navigation helper functions

- (void)showMenu
{
    [self.menuController showMenuFromController:self];
}


#pragma mark - Menu Delegate

- (void)showMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController inViewController:(UIViewController *)viewController
{
    // [self.navigationController presentViewController:JVMenuPopoverViewController animated:NO completion:nil];
}


- (void)closeMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController
{
    [self.navigationController popToViewController:JVMenuPopoverViewController animated:NO];
}


- (void)setNewViewController:(UINavigationController *)navController fromIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [self.navigationController setViewControllers:@[self]];
    }
    else if(indexPath.row == 1)
    {
        [self.navigationController setViewControllers:@[self.secondController]];
    }
    else if (indexPath.row == 2)
    {
        [self.navigationController setViewControllers:@[self.thirdController]];
    }
    else if (indexPath.row == 3)
    {
        [self.navigationController setViewControllers:@[self.fourthController]];
    }
    else if (indexPath.row == 4)
    {
        [self.navigationController setViewControllers:@[self.fifthController]];
    }
}

@end
