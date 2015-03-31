//
//  JVMenuSecondController.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-17.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuSecondController.h"

@interface JVMenuSecondController ()

@end

@implementation JVMenuSecondController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // overriding root controllers label, image and imageview
    self.image = [JVMenuHelper changeImageColor:[UIImage imageNamed:@"about-32"] withColor:[UIColor blackColor]];
    [self.imageView setImage:self.image];
    self.label.text = @"About Us";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
