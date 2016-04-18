//
//  UIVisualEffectView+JVMenuCategory.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-18.
//
//

#import "UIVisualEffectView+JVMenuCategory.h"


@implementation UIVisualEffectView (JVMenuCategory)

+ (UIVisualEffectView * )applyBlurrWithEfftectStyle:(UIBlurEffectStyle)style withFrame:(CGRect)frame
{
    //only apply the blur if the user hasn't disabled transparency effects
    if(!UIAccessibilityIsReduceTransparencyEnabled())
    {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.alpha = 0.6f;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        blurEffectView.frame = frame;
        
        return blurEffectView;
    }
    else
    {
        // ios 7 implementation
    }
    
    return nil;
}

@end
