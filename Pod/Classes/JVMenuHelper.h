//
//  JVMenuHelper.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-16.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVMenuHelper : NSObject

+ (CGSize)getScreenSize;

+ (UIViewController *)topViewController;

+ (UIViewController *)topViewController:(UIViewController *)rootViewController;

+ (UIImage *)takeScreenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)updated;

@end