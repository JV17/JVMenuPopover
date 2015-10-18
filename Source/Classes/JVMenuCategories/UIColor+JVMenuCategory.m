//
//  UIColor+JVMenuCategory.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-10-18.
//
//

#import "UIColor+JVMenuCategory.h"


@implementation UIColor (JVMenuCategory)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    //converts the hex value into a colour
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;

    if (![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    
    return [self colorWithRGBHex:hexNum];
}


+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    //converts a hex number into a colour
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
