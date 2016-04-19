//
//  UIScreen+JVMenuCategory.h
//  Pods
//
//  Created by Jorge on 2016-03-02.
//
//

#import <UIKit/UIKit.h>


@interface UIScreen (JVMenuCategory)

/**
 Returns the screen size depending on the screen orientation.
 */
+ (CGSize)screenSize;


/**
 Returns the interface orientation.
 */
+ (UIInterfaceOrientation)screenOrientation;

@end
