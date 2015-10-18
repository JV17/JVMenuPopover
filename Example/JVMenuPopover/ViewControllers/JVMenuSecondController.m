//
//  JVMenuSecondController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-17.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuSecondController.h"


@implementation JVMenuSecondController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *firstColor = [UIColor colorWithHexString:@"87FC70"];
    UIColor *secondColor = [UIColor colorWithHexString:@"0BD318"];
    
    // setting up new gradient colors
    [self.containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
    
    // overriding root controllers label, image and imageview
    UIImage *newImage = [UIImage imageNamed:@"about-48"];
    self.imageView.image = [newImage changeImageColor:[UIColor blackColor]];
    self.label.text = @"About Us";
}


@end
