//
//  JVTouchHelper.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-04-20.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface JVTouchHelper : NSObject

/**
 *  Handles getting the bundle resources of our project
 *
 *  @return a NSBundle to our project
 */
+ (NSBundle *)myProjectResources;

/**
 *  Handles getting our assets from the bundle resources of our project
 *
 *  @param the name of the asset
 *
 *  @return an UIImage
 */
+ (UIImage *)bundleImageNamed:(NSString *)name;

/**
 *  Creates an UIImage from color, to use as the touch event image
 *
 *  @param the UIColor of the image
 *
 *  @return an UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  Gets a NSString with the Hex color value and transforms it to a UIColor
 *
 *  @param the Hex color value as a NSString
 *
 *  @return an UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *  Gets a Hex color and transforms it to a UIColor using RGB
 *
 *  @param the Hex color value as an UInt32
 *
 *  @return an UIColor
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

@end