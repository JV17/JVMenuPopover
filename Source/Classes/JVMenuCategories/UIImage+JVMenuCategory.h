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

- (UIImage *)changeImageColor:(UIColor *)color;

- (UIImage *)convertImageToSize:(CGSize)size;

+ (UIImage *)takeScreenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)updated;

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

+ (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage inView:(UIView *)senderView;

@end
