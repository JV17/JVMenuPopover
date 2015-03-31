//
//  JVMenuRootViewController.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 03/14/2015.
//  Copyright (c) 2014 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <JVMenuPopover/JVMenuPopoverViewController.h>


@interface JVMenuRootViewController : UIViewController <UINavigationControllerDelegate, JVMenuDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) UIImage *image;

@end