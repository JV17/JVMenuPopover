//
//  JVMenuFourthController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-17.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuFourthController.h"


@implementation JVMenuFourthController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *firstColor = [JVMenuHelper colorWithHexString:@"1AD6FD"];
    UIColor *secondColor = [JVMenuHelper colorWithHexString:@"1D62F0"];
    
    // setting up new gradient colors
    [self.containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
        
    // overriding root controllers label, image and imageview
    UIImage *newImage = [UIImage imageNamed:@"business_contact-48"];
    self.imageView.image = [newImage changeImageColor:[UIColor blackColor]];
    self.label.text = @"Contact Us";
}


@end