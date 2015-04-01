//
//  JVMenuFifthController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-30.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuFifthController.h"

@interface JVMenuFifthController ()

@end

@implementation JVMenuFifthController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // remove gradient layer from container view
    [JVMenuHelper removeLayerFromView:self.containerView];
    
    // gradient background color
    CAGradientLayer *newGradient = [CAGradientLayer layer];
    newGradient.frame = self.view.frame;
    UIColor *firstColor = [JVMenuHelper colorWithHexString:@"EF4DB6"];
    UIColor *secondColor = [JVMenuHelper colorWithHexString:@"C643FC"];
    
    newGradient.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    [self.containerView.layer insertSublayer:newGradient atIndex:0];
        
    // overriding root controllers label, image and imageview
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"ask_question-48"] withColor:[UIColor blackColor]];
    [self.imageView setImage:self.image];
    self.label.text = @"Help?";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end