//
//  JVMenuFourthController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-17.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuFourthController.h"

@interface JVMenuFourthController ()

@end

@implementation JVMenuFourthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // remove gradient layer from container view
    [JVMenuHelper removeLayerFromView:self.containerView];
    
    // gradient background color
    CAGradientLayer *newGradient = [CAGradientLayer layer];
    newGradient.frame = self.view.frame;
    UIColor *firstColor = [UIColor colorWithRed:0.0f/255.0f
                                          green:40.0f/255.0f
                                           blue:96.0f/255.0f
                                          alpha:1.0f];
    UIColor *secondColor = [UIColor colorWithRed:0.0f/255.0f
                                           green:100.0f/255.0f
                                            blue:232.0f/255.0f
                                           alpha:1.0f];
    
    newGradient.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    [self.containerView.layer insertSublayer:newGradient atIndex:0];
        
    // overriding root controllers label, image and imageview
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"business_contact-48"] withColor:[UIColor blackColor]];
    [self.imageView setImage:self.image];
    self.label.text = @"Contact Us";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end