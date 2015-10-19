//
//  JVMenuPopoverView.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-14.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@class JVMenuPopoverView;


#pragma mark - Protocol

@protocol JVMenuPopoverDelegate <NSObject>

@optional

/**
 Tells the selected index path from the menu.
 
 @param JVMenuPopoverView
    The menu view.
 @param indexPath
    The index path of the menu.
 */
- (void)menuPopover:(JVMenuPopoverView *)JVMenuPopoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark - Interface

@interface JVMenuPopoverView : UIView <UITableViewDelegate, UITableViewDataSource>

/** JVMenuPopoverDelegate. */
@property (nonatomic, weak) id<JVMenuPopoverDelegate> delegate;


/** The table view that holds the menu. */
@property (nonatomic, strong, readwrite) UITableView *tableView;


/** The type of animation. */
@property (nonatomic, assign, readwrite) BOOL slideInAnimation;


/** The type of animation. */
@property (nonatomic, assign, readwrite) BOOL slideInWithBounceAnimation;


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
 @param images
    The array of images to be used in the menu.
 @param titles
    The array of titles to be used in the menu.
 
 @return
    An instance type of @a JVMenuPopoverView.
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles;

@end
