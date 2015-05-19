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
// menu methods
- (void)menuPopover:(JVMenuPopoverView *)JVMenuPopoverView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark - Interface
@interface JVMenuPopoverView : UIView <UITableViewDelegate, UITableViewDataSource>

// Delegate
@property (nonatomic, weak) id<JVMenuPopoverDelegate> delegate;

// Public Properties
@property (nonatomic, strong) UITableView *tableView;

// Initializers
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;

@end