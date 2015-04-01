//
//  JVMenuHelper.h
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-16.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JVMenuHelper : NSObject

+ (CGSize)getScreenSize;

+ (UIViewController *)topViewController;

+ (UIViewController *)topViewController:(UIViewController *)rootViewController;

+ (UIImage *)takeScreenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)updated;

+ (UIImage *)changeImageColor:(UIImage *)img withColor:(UIColor *)color;

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;

+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

+ (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage inView:(UIView *)senderView;

+ (UIVisualEffectView * )applyBlurrWithEfftectStyle:(UIBlurEffectStyle)style withFrame:(CGRect)frame;

@end