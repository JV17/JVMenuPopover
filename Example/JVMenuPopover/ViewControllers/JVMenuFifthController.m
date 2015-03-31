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
        
    // overriding root controllers label, image and imageview
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"ask_question_filled-32"] withColor:[UIColor blackColor]];
    [self.imageView setImage:self.image];
    self.label.text = @"Help?";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end