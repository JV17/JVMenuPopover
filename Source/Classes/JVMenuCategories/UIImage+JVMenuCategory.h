//
//  UIImage+JVMenuCategory.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-10-17.
//  Copyright © 2015 Jorge Valbuena. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (JVMenuCategory)

/**
 Scales image to specified width.
 
 @param toWidth
    The preferred width for the image.
 */
- (UIImage *)imageScaledToWidth:(CGFloat)toWidth;


/**
 Changes image color to specified color.
 
 @param color
    The new image color.
 
 @return
    The new image with the new color.
 */
- (UIImage *)changeImageColor:(UIColor *)color;


/**
 Takes a screenshot of specified view with after screen updates.
 
 @param view
    The view to take a screenshot of.
 @param updated
    Tells if the screenshot should be taken before or after the screen updates.
 
 @return
    The new screenshot of the provided view as an image.
 */
+ (UIImage *)takeScreenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)updated;

@end
