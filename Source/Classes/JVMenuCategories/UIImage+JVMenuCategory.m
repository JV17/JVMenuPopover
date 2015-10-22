//
//  UIImage+JVMenuCategory.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-10-17.
//  Copyright © 2015 Jorge Valbuena. All rights reserved.
//

#import "UIImage+JVMenuCategory.h"
#import <Accelerate/Accelerate.h>


@implementation UIImage (JVMenuCategory)

- (UIImage *)imageScaledToWidth:(CGFloat)toWidth
{
    CGFloat oldWidth = self.size.width;
    CGFloat scaleFactor = toWidth / oldWidth;
    
    CGFloat newHeight = self.size.height * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [self drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (UIImage *)changeImageColor:(UIColor *)color
{
    if (color)
    {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        
        CGContextClipToMask(context, rect, self.CGImage);
        
        [color setFill];
        
        CGContextFillRect(context, rect);
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    return self;
}


+ (UIImage *)takeScreenShotOfView:(UIView *)view afterScreenUpdates:(BOOL)updated
{
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    
    [view drawViewHierarchyInRect:view.frame afterScreenUpdates:updated];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
