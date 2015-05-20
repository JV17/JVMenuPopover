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
@protocol JVMenuPopoverViewControllerDelegate <NSObject>

@required
- (void)setNewViewController:(UINavigationController *)navController fromIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)showMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController inViewController:(UIViewController *)viewController;
- (void)closeMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController;

@end

#pragma mark - Interface
@interface JVMenuPopoverViewController : UIViewController <JVMenuPopoverDelegate>

// properties
@property (nonatomic, weak) id <JVMenuPopoverViewControllerDelegate> delegate;
@property (nonatomic, strong) JVMenuPopoverView *menuView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIImage *closeImage;
@property (nonatomic, assign) BOOL slideInAnimation;
@property (nonatomic, assign) BOOL slideInWithBounceAnimation;

// initializer
- (instancetype)initWithImages:(NSArray *)images titles:(NSArray *)titles closeImage:(UIImage *)closeImage;

// Menu helper functions
- (void)showMenuFromController:(UIViewController *)viewController;
- (void)closeMenuFromController:(UIViewController *)viewController;

@end