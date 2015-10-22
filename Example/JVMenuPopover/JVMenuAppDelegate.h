//
//  JVMenuAppDelegate.h
//  JVMenuPopover
//
//  Created by CocoaPods on 03/14/2015.
//  Copyright (c) 2014 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JVMenuRootViewController, JVMenuNavigationController;

@interface JVMenuAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) JVMenuRootViewController *rootViewController;

@property (strong, nonatomic) JVMenuNavigationController *navigationController;

@property (strong, nonatomic) UIWindow *window;

@end