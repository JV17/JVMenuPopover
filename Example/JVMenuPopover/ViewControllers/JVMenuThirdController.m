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
        
    // overriding root controllers label, image and imageview
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"settings-32"] withColor:[UIColor blackColor]];
    [self.imageView setImage:self.image];
    self.label.text = @"Our Services";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end