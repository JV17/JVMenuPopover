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


#pragma mark UIImage Effects

+ (UIImage *)imageByApplyingLightEffectToImage:(UIImage *)inputImage;


+ (UIImage *)imageByApplyingExtraLightEffectToImage:(UIImage *)inputImage;


+ (UIImage *)imageByApplyingDarkEffectToImage:(UIImage *)inputImage;


+ (UIImage *)imageByApplyingTintEffectWithColor:(UIColor *)tintColor toImage:(UIImage *)inputImage;


/**
 Applies a blur, tint color, and saturation adjustment to @a inputImage, optionally within the area specified by @a maskImage.

 @param  inputImage
    The source image.  A modified copy of this image will be returned.
 @param  blurRadius
    The radius of the blur in points.
 @param  tintColor
     An optional UIColor object that is uniformly blended with the
     result of the blur and saturation operations.  The alpha channel
     of this color determines how strong the tint is.
 @param  saturationDeltaFactor
     A value of 1.0 produces no change in the resulting image.  Values
     less than 1.0 will desaturation the resulting image while values
     greater than 1.0 will have the opposite effect.
 @param  maskImage
     If specified, @a inputImage is only modified in the area(s) defined
     by this mask.  This must be an image mask or it must meet the
     requirements of the mask parameter of CGContextClipToMask.
 
 @return
    The new image with the applied blur effect.
 */
+ (UIImage *)imageByApplyingBlurToImage:(UIImage *)inputImage withRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
