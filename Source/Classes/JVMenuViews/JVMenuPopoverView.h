//
//  JVMenuPopoverView.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-14.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@class JVMenuPopoverView, JVMenuItems;


#pragma mark - Protocol

@protocol JVMenuPopoverDelegate <NSObject>

@optional

/**
 Tells the selected view controller with @a indexPath.
 
 @param indexPath
    The index path of the menu.
 */
- (void)menuPopoverDidSelectViewControllerAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark - Interface

@interface JVMenuPopoverView : UIView <UITableViewDelegate, UITableViewDataSource>

#pragma mark Properties

/** JVMenuPopoverDelegate. */
@property (nonatomic, weak) id<JVMenuPopoverDelegate> delegate;


/** Holds the menu data model containig an array of images, titles and the close button image. */
@property (nonatomic, strong, readwrite) JVMenuItems *menuItems;


#pragma mark Initializers

/** Throws an @a NSException telling the user that should use custom initializer. */
- (instancetype)init;


/** Throws an @a NSException telling the user that should use custom initializer. */
- (instancetype)initWithFrame:(CGRect)frame;


/** Throws an @a NSException telling the user that should use custom initializer. */
- (instancetype)initWithCoder:(NSCoder *)aDecoder;


/**
 Custom initializer for the @a JVMenuPopoverView with specified frame, array of images and array titles to be used in the menu.
 
 @param frame
    The view frame to be drawn.
 @param menuItems
    The menu data model with an array of images, titles and the close button image.
 
 @return
    An instance type of @a JVMenuPopoverView.
 */
- (instancetype)initWithFrame:(CGRect)frame menuItems:(JVMenuItems *)menuItems;


#pragma mark Show & Close Menu

/**
 Shows @a JVMenuPopover from specified view controller.
 
 @param viewController
    The view controller where to show the menu from.
 */
- (void)showMenuWithController:(UIViewController *)viewController;


/** Closes @a JVMenuPopover from specified view controller. */
- (void)closeMenu;


@end
