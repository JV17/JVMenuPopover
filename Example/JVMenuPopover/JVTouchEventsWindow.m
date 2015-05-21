//
//  JVTouchEventsWindow.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-04-20.
//
//

#import "JVTouchEventsWindow.h"
#import "JVTouchImageViewQueue.h"


@interface JVTouchEventsWindow ()

@property (nonatomic, strong) JVTouchImageViewQueue *touchImageViewQueue;
@property (nonatomic, strong) NSMutableDictionary *touchImageViewsDic;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGSize size;

@end


@implementation JVTouchEventsWindow

#pragma mark - Initializers

/**
 *  Initializer for our JVTouchEventsWindow, which throws an exception to avoid the use of this initializer
 *  instead use initWithFrame
 *
 *  @return an NSException
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"Use the `initWithFrame:(CGRect)frame` method instead."
                                 userInfo:nil];
}

/**
 *  Initializer for our JVTouchEventsWindow with the screen bounds, default image color and default image size
 *
 *  @return an initialized JVTouchEventsWindow
 */
- (instancetype)init
{
    return [self initWithFrame:[UIScreen mainScreen].bounds
                 andImageColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.7]
                 withImageSize:CGSizeMake(40, 40)];
}

/**
 *  Initializer for our JVTouchEventsWindow with screen bounds, default image color and default image size
 *
 *  @param a CGRect, which represents the screen bounds
 *
 *  @return an initialized JVTouchEventsWindow
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame
                 andImageColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.7]
                 withImageSize:CGSizeMake(40, 40)];
}

/**
 *  Custom initializer for our JVTouchEventsWindow with the screen bounds, custom image color, custom image size
 *
 *  @param a CGRect, which represents the screen bounds
 *  @param a UIColor, which represents the custom image color
 *  @param a CGRect, which represents the custom image size
 *
 *  @return an initialized JVTouchEventsWindow
 */
- (instancetype)initWithFrame:(CGRect)frame andImageColor:(UIColor *)color withImageSize:(CGSize)size
{
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    self.color = (color != nil) ? color : [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    self.size = (size.width != 0.0f || size.height != 0.0f) ? size : CGSizeMake(TOUCH_SIZE, TOUCH_SIZE);
    
    return self;
}


#pragma mark - Touch Events

/**
 *  Handles the UIWindow touch events, here we want to perform different operations
 *  depending of the touch phase, like adding a new ImageView or removing last added
 *
 *  @param the touch event
 *
 *  @return n/a
*/
- (void)sendEvent:(UIEvent *)event
{
    NSSet *touches = [event allTouches];
    
    for (UITouch *touch in touches)
    {
        switch ([touch phase])
        {
            case UITouchPhaseBegan:
                [self touchBegan:touch];
                break;
                
            case UITouchPhaseMoved:
                [self touchMoved:touch];
                break;
                
            case UITouchPhaseEnded:
            case UITouchPhaseCancelled:
                [self touchEnded:touch];
                break;
                
            default:
                break;
        }
    }
    
    [super sendEvent:event];
}


#pragma mark - Touch events helper functions

/**
 *  Handles the touch phase began state, here we want to set the new ImageView for 
 *  the touch event
 *
 *  @param a touch
 *
 *  @return n/a
*/
- (void)touchBegan:(UITouch *)touch
{
    UIImageView *touchImageView = [self.touchImageViewQueue popTouchImageView];
    touchImageView.center = [touch locationInView:self];
    [self addSubview:touchImageView];
    
    touchImageView.alpha = 0.0;
    touchImageView.transform = CGAffineTransformMakeScale(1.13, 1.13);
    
    [self setTouchImageView:touchImageView forTouch:touch];
    
    [UIView animateWithDuration:0.1
                     animations:^{
                        touchImageView.alpha = 1.0f;
                        touchImageView.transform = CGAffineTransformMakeScale(1, 1);
                     }];
}

/**
 *  Handles the touch phase moved state, here we want to set the new ImageView within
 *  our ImageView dictionary
 *
 *  @param a touch
 *
 *  @return n/a
 */
- (void)touchMoved:(UITouch *)touch
{
    UIImageView *touchImageView = [self touchImageViewForTouch:touch];
    touchImageView.center = [touch locationInView:self];
}

/**
 *  Handles the touch phase end/cancelled state, here we want to remove the ImageView
 *  previously added
 *
 *  @param a touch
 *
 *  @return n/a
 */
- (void)touchEnded:(UITouch *)touch
{
    UIImageView *touchImageView = [self touchImageViewForTouch:touch];
    
    [UIView animateWithDuration:0.1
                     animations:^ {
                         touchImageView.alpha = 0.0f;
                         touchImageView.transform = CGAffineTransformMakeScale(1.13, 1.13);
                     }
                     completion:^(BOOL finished) {
                         [touchImageView removeFromSuperview];
                         touchImageView.alpha = 1.0;
                         [self.touchImageViewQueue pushTouchImageView:touchImageView];
                         [self removeTouchImageViewForTouch:touch];
                     }];
}


#pragma mark - ImageView helper functions

/**
 *  Helper function to get ImageViews from our dictionary
 *
 *  @param a touch
 *
 *  @return n/a
 */
- (UIImageView *)touchImageViewForTouch:(UITouch *)touch
{
    NSString *touchStringHash = [NSString stringWithFormat:@"%lu", (unsigned long)[touch hash]];
    
    return self.touchImgViewsDict[touchStringHash];
}

/**
 *  Helper function to set the ImageView in our dictionary
 *
 *  @param a Imageview and a touch
 *
 *  @return n/a
 */
- (void)setTouchImageView:(UIImageView *)imgView forTouch:(UITouch *)touch
{
    NSString *touchStringHash = [NSString stringWithFormat:@"%lu", (unsigned long)[touch hash]];
    
    [self.touchImgViewsDict setObject:imgView forKey:touchStringHash];
}

/**
 *  Helper function to remove ImageView from our dictionary
 *
 *  @param a touch
 *
 *  @return n/a
 */
- (void)removeTouchImageViewForTouch:(UITouch *)touch
{
    NSString *touchStringHash = [NSString stringWithFormat:@"%lu", (unsigned long)[touch hash]];
    
    [self.touchImgViewsDict removeObjectForKey:touchStringHash];
}


#pragma mark - Custom getters & setters

/**
 *  Lazy loading initializer for our touchImageViewQueue
 *
 *  @return a initialized JVTouchImageViewQueue
 */
- (JVTouchImageViewQueue *)touchImageViewQueue
{
    if (!_touchImageViewQueue)
    {
        _touchImageViewQueue = [[JVTouchImageViewQueue alloc] initWithTouchesCount:8
                                                                     andImageColor:self.color
                                                                     withImageSize:self.size];
    }
    
    return _touchImageViewQueue;
}

/**
 *  Lazy loading initializer for our touchImgViewsDict
 *
 *  @return a initialized NSMutableDictionary
 */
- (NSMutableDictionary *)touchImgViewsDict
{
    if (!_touchImageViewsDic)
    {
        _touchImageViewsDic = [[NSMutableDictionary alloc] init];
    }
    
    return _touchImageViewsDic;
}

@end