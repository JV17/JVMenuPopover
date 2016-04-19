//
//  UIView+JVMenuCategory.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-10-17.
//  Copyright © 2015 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (JVMenuCategory)

/**
 Adds the new gradient effect with specifies colors.
 
 @param firstColor
    The first color to be used in the gradient effect.
 @param secondColor
    The second color to be used in the gradient effect.
 */
- (void)gradientEffectWithFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor;


/** Removes layer from caller view. */
- (void)removeLayerFromView;

@end
