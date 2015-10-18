//
//  JVMenuThirdController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-17.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuThirdController.h"


@implementation JVMenuThirdController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *firstColor = [UIColor colorWithHexString:@"FB2B69"];
    UIColor *secondColor = [UIColor colorWithHexString:@"FF5B37"];
    
    // setting up new gradient colors
    [self.containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
    
    // overriding root controllers label, image and imageview
    UIImage *newImage = [UIImage imageNamed:@"settings-48"];
    self.imageView.image = [newImage changeImageColor:[UIColor blackColor]];
    self.label.text = @"Our Services";
}


@end