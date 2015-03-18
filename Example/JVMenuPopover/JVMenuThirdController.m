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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-60, self.view.frame.size.height/2-20, 120, 40)];
    label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:22];
    label.textColor = [UIColor blackColor];
    label.text = @"JVMenu!";
    
    [self.view addSubview:label];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end