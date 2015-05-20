//
//  JVMenuPushAnimator.m
//  Pods
//
//  Created by Jorge Valbuena on 2015-05-19.
//
//

#import "JVMenuPushAnimator.h"


@implementation JVMenuPushAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.3/1.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] addSubview:toViewController.view];
    
    toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
        
    // spring animations
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // animations
                         toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     }
                     completion:^(BOOL finished) {
                         // completion
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];

}

@end