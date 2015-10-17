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
    
    UIColor *firstColor = [JVMenuHelper colorWithHexString:@"FB2B69"];
    UIColor *secondColor = [JVMenuHelper colorWithHexString:@"FF5B37"];
    
    // setting up new gradient colors
    [self.containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
    
    // overriding root controllers label, image and imageview
    self.imageView.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"settings-48"] withColor:[UIColor blackColor]];
    self.label.text = @"Our Services";
}


@end