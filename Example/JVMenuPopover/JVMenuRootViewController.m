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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)commonInit
{
    // no background color
    self.view.backgroundColor = [UIColor clearColor];
    self.containerView = [[UIView alloc] initWithFrame:self.view.frame];
    
    // gradient background color
    self.gradient = [CAGradientLayer layer];
    self.gradient.frame = self.view.frame;
    UIColor *firstColor = [JVMenuHelper colorWithHexString:@"52EDC7"];
    UIColor *secondColor = [JVMenuHelper colorWithHexString:@"5AC8FB"];
    
    // gradient colors
    self.gradient.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    [self.containerView.layer insertSublayer:self.gradient atIndex:0];
    
    // setting up controller image
    self.menuImg = [UIImage imageNamed:@"menu_black-48"];
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"home-48"] withColor:[UIColor blackColor]];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-self.image.size.width/2, self.view.frame.size.height/2-30, self.image.size.width, self.image.size.height)];
    [self.imageView setImage:self.image];
    
    [self.containerView addSubview:self.imageView];
    
    // setting controllers label
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-110, self.view.frame.size.height/2-20, 220, 60)];
    self.label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.label.textColor = [UIColor blackColor];
    self.label.text = @"Home";
    
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
        self.mainController = [[JVMenuRootViewController alloc] init];
        [self.navigationController setViewControllers:@[self.mainController]];
    }
    else if(indexPath.row == 1)
    {
        self.secondController = [[JVMenuSecondController alloc] init];
        [self.navigationController setViewControllers:@[self.secondController]];
    }
    else if (indexPath.row == 2)
    {
        self.thirdController = [[JVMenuThirdController alloc] init];
        [self.navigationController setViewControllers:@[self.thirdController]];
    }
    else if (indexPath.row == 3)
    {
        self.fourthController = [[JVMenuFourthController alloc] init];
        [self.navigationController setViewControllers:@[self.fourthController]];
    }
    else if (indexPath.row == 4)
    {
        self.fifthController = [[JVMenuFifthController alloc] init];
        [self.navigationController setViewControllers:@[self.fifthController]];
    }
    
}

@end
