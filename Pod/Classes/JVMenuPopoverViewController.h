//
//  JVMenuPopoverViewController.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-16.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVMenuPopoverView.h>

@class JVMenuPopoverViewController;

#pragma mark - Protocol
@protocol JVMenuDelegate <NSObject>

@optional
- (void)showMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController inViewController:(UIViewController *)viewController;
- (void)closeMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController;

@end

#pragma mark - Interface
@interface JVMenuPopoverViewController : UIViewController

@property (nonatomic, weak) id <JVMenuDelegate> delegate;

@property (nonatomic, strong) JVMenuPopoverView *menuView;

// Menu helper functions
- (void)showMenuFromController:(UIViewController *)viewController;
- (void)closeMenuFromController:(UIViewController *)viewController;

@end