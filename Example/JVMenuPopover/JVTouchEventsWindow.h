//
//  JVTouchEventsWindow.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-04-20.
//
//

#import <UIKit/UIKit.h>


@interface JVTouchEventsWindow : UIWindow

/**
 *  Initializer for our JVTouchEventsWindow, which throws an exception to avoid the use of this initializer
 *  instead use initWithFrame
 *
 *  @return an NSException
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

/**
 *  Initializer for our JVTouchEventsWindow with the screen bounds, default image color and default image size
 *
 *  @return an initialized JVTouchEventsWindow
 */
- (instancetype)init;

/**
 *  Initializer for our JVTouchEventsWindow with screen bounds, default image color and default image size
 *
 *  @param a CGRect, which represents the screen bounds
 *
 *  @return an initialized JVTouchEventsWindow
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 *  Custom initializer for our JVTouchEventsWindow with the screen bounds, custom image color, custom image size
 *
 *  @param a CGRect, which represents the screen bounds
 *  @param a UIColor, which represents the custom image color
 *  @param a CGRect, which represents the custom image size
 *
 *  @return an initialized JVTouchEventsWindow
 */
- (instancetype)initWithFrame:(CGRect)frame andImageColor:(UIColor *)color withImageSize:(CGSize)size;

@end