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