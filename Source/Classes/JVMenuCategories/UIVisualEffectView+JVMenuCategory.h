//
//  UIVisualEffectView+JVMenuCategory.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-18.
//
//

#import <UIKit/UIKit.h>


@interface UIVisualEffectView (JVMenuCategory)

/**
 Creates a new visual effect view with blur effect style and specified frame.
 
 @param style
    The desired blur effect.
 @param frame
    The frame of the visual effect view.
 
 @return
    The new visual effect with blur effect and frame.
 */
+ (UIVisualEffectView * )applyBlurrWithEfftectStyle:(UIBlurEffectStyle)style withFrame:(CGRect)frame;

@end
