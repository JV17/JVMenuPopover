//
//  UIColor+JVMenuCategory.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-18.
//
//

#import <UIKit/UIKit.h>


@interface UIColor (JVMenuCategory)

/**
 Converts a hex string color to UIColor.
 
 @param stringToConvert
    The hex string color to convert.
 
 @return
    The new color.
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;


/**
 Converts a UInt32 hex color to UIColor.
 
 @param hex
    The UInt32 hex color to convert.
 
 @return
    The new color.
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

@end
