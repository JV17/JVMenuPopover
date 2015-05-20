//
//  JVMenuTransitions.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import "JVMenuTransitions.h"

@interface JVMenuTransitions()

// booleans for presenting
@property (nonatomic) BOOL presenting;

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

// keeping a reference of viewcontroller views from, to and container..
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *fromView;
@property (nonatomic, strong) UIView *toView;

@property (nonatomic) CGFloat animationDuration;

@end

// constants
static CGFloat const kDuration = 1.3/1.5;

@implementation JVMenuTransitions

#pragma mark - UIViewControllerAnimatedTransitioning protocol methods

// animate a change from one viewcontroller to another
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // updating reference to transitionContext
    if(transitionContext)
    {
        self.transitionContext = transitionContext;
    }
    else
    {
        return;
    }
    
    // get reference to our fromView, toView and the container view that we should perform the transition in
    self.container = [self.transitionContext containerView];
    self.fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    self.toView = [self.transitionContext viewForKey:UITransitionContextToViewKey];
    
    // get the duration of the animation
    self.animationDuration = [self transitionDuration:self.transitionContext];
    
    // triggering the type of animation choosed
    [self performTransitionAnimation];
    
}

// return how many seconds the transiton animation will take
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return kDuration;
}


#pragma mark - UIViewControllerTransitioningDelegate protocol methods

// return the animataor when presenting a viewcontroller
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.presenting = YES;
    return self;
}

// return the animator used when dismissing from a viewcontroller
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.presenting = NO;
    return self;
}


#pragma mark - Transition Animations

- (void)performTransitionAnimation
{
    // prepare the toView for the animation
    self.toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
    
    // add the both views to our view controller
    [self.container addSubview:self.fromView];
    [self.container addSubview:self.toView];
    
    // spring animations
    [UIView animateWithDuration:self.animationDuration
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // animations
                         self.toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }
                     completion:^(BOOL finished) {
                         // completion
                         if (finished) {
                             
                         }
                     }];
}

@end