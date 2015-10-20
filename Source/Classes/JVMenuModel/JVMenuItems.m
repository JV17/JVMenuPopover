//
//  JVMenuItems.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-19.
//
//

#import "JVMenuItems.h"


@implementation JVMenuItems

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _menuSlideInWithBounceAnimation = YES;
    }
    
    return self;
}


- (instancetype)initWithMenuImages:(NSArray *)images menuTitles:(NSArray *)titles menuCloseButtonImage:(UIImage *)closeImage
{
    self = [super init];
    
    if (self)
    {
        _menuImages = images;
        _menuTitles = titles;
        _menuCloseButtonImage = closeImage;
        _menuSlideInWithBounceAnimation = YES;
    }
    
    return self;
}

@end
