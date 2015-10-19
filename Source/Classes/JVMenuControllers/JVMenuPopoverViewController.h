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

/**
 Sets new view controller depending on selected @a indexPath.
 
 @param navController
    The navigation controller.
 @param indexPath
  The selected index path.
 */
- (void)setNewViewController:(UINavigationController *)navController fromIndexPath:(NSIndexPath *)indexPath;


@optional

/**
 Tells the navigation controller to present new view controller.
 
 @param jvMenuPopoverViewController
    The jv menu view controller.
 @param viewController
    The view controller where the menu will be shown.
 */
- (void)showMenu:(JVMenuPopoverViewController *)jvMenuPopoverViewController inViewController:(UIViewController *)viewController;


/**
 Tells the navigation controller to dismiss view controller.
 
 @param jvMenuPopoverViewController
    The jv menu view controller.
 */
- (void)closeMenu:(JVMenuPopoverViewController *)jvMenuPopoverViewController;

@end


#pragma mark - Interface

@interface JVMenuPopoverViewController : UIViewController <JVMenuPopoverDelegate>

/** JVMenuPopoverViewControllerDelegate. */
@property (nonatomic, weak) id <JVMenuPopoverViewControllerDelegate> delegate;


/** The menu popover view which holds the menu. */
@property (nonatomic, strong, readwrite) JVMenuPopoverView *menuView;


/** The array of images to be used in the menu. */
@property (nonatomic, strong, readwrite) NSArray *images;


/** The array of titles to be used in the menu. */
@property (nonatomic, strong, readwrite) NSArray *titles;


/** The close image to be used in the close button in the menu. */
@property (nonatomic, strong, readwrite) UIImage *closeImage;


/** This is the type of animation @a slideInAnimation used for how the content of the menu shows up. */
@property (nonatomic, assign, readwrite) BOOL slideInAnimation;


/** This is the type of animation @a slideInWithBounceAnimation used for how the content of the menu shows up. */
@property (nonatomic, assign, readwrite) BOOL slideInWithBounceAnimation;


/**
 Custom initializer with an array of images, an array of titles and the close image.
 
 @param images
    An array holding the set of images to be used for each menu item.
 @param titles
    An array holding the set of titles to be used for each menu item.
 @param closeImage
    The image to be used for the close button.
 
 @return
    An instance of JVMenuPopoverViewController.
 */
- (instancetype)initWithImages:(NSArray *)images titles:(NSArray *)titles closeImage:(UIImage *)closeImage;


/**
 Shows @a JVMenuPopover from specified view controller.
 
 @param viewController
    The view controller where to show the menu from.
 */
- (void)showMenuFromController:(UIViewController *)viewController;


/**
 Closes @a JVMenuPopover from specified view controller.
 
 @param viewController
    The view controller where to close the menu from.
 */
- (void)closeMenuFromController:(UIViewController *)viewController;

@end