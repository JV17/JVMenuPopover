//
//  JVMenuFifthController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-30.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuFifthController.h"


@implementation JVMenuFifthController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *firstColor = [JVMenuHelper colorWithHexString:@"EF4DB6"];
    UIColor *secondColor = [JVMenuHelper colorWithHexString:@"C643FC"];

    // setting up new gradient colors
    [self.containerView gradientEffectWithFirstColor:firstColor secondColor:secondColor];
        
    // overriding root controllers label, image and imageview
    self.imageView.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"ask_question-48"] withColor:[UIColor blackColor]];
    self.label.text = @"Help?";
}


@end