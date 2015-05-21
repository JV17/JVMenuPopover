//
//  JVTouchImageViewQueue.h
//  Pods
//
//  Created by Jorge Valbuena on 2015-04-20.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define TOUCH_IMAGE @"JVTouchImage"
#define TOUCH_COUNT 8
#define TOUCH_SIZE 40


@interface JVTouchImageViewQueue : NSObject

/**
 *  Initializer for our JVTouchImageViewQueue with the queue size, image color and image size
 *
 *  @return an initialized JVTouchImageViewQueue
 */
- (instancetype)init;

/**
 *  Custom initializer for our JVTouchImageViewQueue with the queue size
 *
 *  @param a NSUInteger, which represents the size of our queue
 *
 *  @return an initialized instancetype
*/
- (instancetype)initWithTouchesCount:(NSUInteger)count;

/**
 *  Custom initializer for our JVTouchImageViewQueue with the queue size, image color and image size
 *
 *  @param a NSUInteger, which represents the size of our queue
 *  @param a UIColor, which represents the color of our touches image
 *  @param a CGSize, which represents the size of our touches image
 *
 *  @return an initialized JVTouchImageViewQueue
 */
- (instancetype)initWithTouchesCount:(NSUInteger)count andImageColor:(UIColor *)color withImageSize:(CGSize)size;

/**
 *  A helper function to remove ImageViews from our queue
 *
 *  @return the new queue without the removed ImageView
 */
- (UIImageView *)popTouchImageView;

/**
 *  A helper function to add ImageView to our queue
 *
 *  @param an UIImageView to be added to queue
 *
 *  @return n/a
 */
- (void)pushTouchImageView:(UIImageView *)touchImageView;

@end