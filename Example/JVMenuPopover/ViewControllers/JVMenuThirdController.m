//
//  JVMenuThirdController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-17.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuThirdController.h"

@interface JVMenuThirdController ()

@end

@implementation JVMenuThirdController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // removing previous gradient from container
    [JVMenuHelper removeLayerFromView:self.containerView];
    
    // gradient background color
    CAGradientLayer *newGradient = [CAGradientLayer layer];
    newGradient.frame = self.view.frame;
    UIColor *firstColor = [JVMenuHelper colorWithHexString:@"FB2B69"];
    UIColor *secondColor = [JVMenuHelper colorWithHexString:@"FF5B37"];
    
    newGradient.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    [self.containerView.layer insertSublayer:newGradient atIndex:0];
    
    // overriding root controllers label, image and imageview
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"settings-48"] withColor:[UIColor blackColor]];
    [self.imageView setImage:self.image];
    self.label.text = @"Our Services";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end