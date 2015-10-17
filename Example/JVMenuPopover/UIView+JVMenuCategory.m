//
//  UIView+JVMenuCategory.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-10-17.
//  Copyright © 2015 Jorge Valbuena. All rights reserved.
//

#import "UIView+JVMenuCategory.h"


@implementation UIView (JVMenuCategory)

- (void)gradientEffectWithFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor
{
    // removing previous gradient from container
    [self removeLayerFromView];
    
    // gradient background color
    CAGradientLayer *newGradient = [CAGradientLayer layer];
    newGradient.frame = self.frame;
    
    // setting new gradient colors
    newGradient.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor, (id)secondColor.CGColor, nil];
    
    // adding the new gradient
    [self.layer insertSublayer:newGradient atIndex:0];
}


- (void)removeLayerFromView
{
    CAGradientLayer *layerToRemove;
 
    for (CALayer *aLayer in self.layer.sublayers)
    {
        if ([aLayer isKindOfClass:[CAGradientLayer class]])
        {
            layerToRemove = (CAGradientLayer *)aLayer;
        }
    }
    
    [layerToRemove performSelector:@selector(removeFromSuperlayer)];
}

@end
