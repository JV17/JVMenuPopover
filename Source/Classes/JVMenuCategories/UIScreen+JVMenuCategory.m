//
//  UIScreen+JVMenuCategory.m
//  Pods
//
//  Created by Jorge on 2016-03-02.
//
//

#import "UIScreen+JVMenuCategory.h"


@implementation UIScreen (JVMenuCategory)

+ (CGSize)screenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIScreen screenOrientation]))
    {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    
    return screenSize;
}


+ (UIInterfaceOrientation)screenOrientation
{
    return [UIApplication sharedApplication].statusBarOrientation;
}

@end
