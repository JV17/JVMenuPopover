//
//  JVMenuAppDelegate.m
//  JVMenuPopover
//
//  Created by CocoaPods on 03/14/2015.
//  Copyright (c) 2014 Jorge Valbuena. All rights reserved.
//

#import "JVMenuAppDelegate.h"


@implementation JVMenuAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.rootViewController = [[JVMenuRootViewController alloc] init];
    
    // setting up navigation controller with root controller & transparent nav bar
    self.navigationController = [[JVMenuNavigationController alloc] initWithRootViewController:self.rootViewController];
    self.navigationController.withTransparentNavBar = YES;
    
    // setting up app window
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.navigationController];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[JVMenuHelper imageWithImage:[UIImage imageNamed:@"app_bg1.jpg"] scaledToWidth:self.window.frame.size.width]];
    self.window.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (JVTouchEventsWindow *)window
{
    static JVTouchEventsWindow *sharedWindow = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWindow = [[JVTouchEventsWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                    andImageColor:[[UIColor grayColor] colorWithAlphaComponent:0.7]
                                                    withImageSize:CGSizeMake(40, 40)];
    });
    
    return sharedWindow;
}

@end
