# JVMenuPopover

###### In Development!

[![Version](https://img.shields.io/cocoapods/v/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover)
[![License](https://img.shields.io/cocoapods/l/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover)
[![Platform](https://img.shields.io/cocoapods/p/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover)

### Preview 1 - Menu with Background pic

<a href="http://www.youtube.com/watch?feature=player_embedded&v=PeAu5T2dbAk?autoplay=1" target="_blank">![screenshot-1](Example/Previews/menu_with_bgpic.gif)</a>

### Preview 2 - Menu without Background pic

<a href="http://www.youtube.com/watch?feature=player_embedded&v=zcLHQHAZeU8?autoplay=1" target="_blank">![screenshot-1](Example/Previews/menu_with_nobgpic.gif)</a>

### Preview 3 - Menu with Vibrancy

<a href="http://www.youtube.com/watch?feature=player_embedded&v=_9OrMZ7VYDI?autoplay=1" target="_blank">![screenshot-1](Example/Previews/menu_with_vibrancy.gif)</a>

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Using JVMenuPopover with your own project.

* Set your RootViewController in the your AppDelegate.m, you could follow my example project and see how I set a background image to the entire app if you are looking to follow that approach.
    * I use one of my helper function in the pods to adjust the image to my device width and not show an expanded image.
    
``` 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIViewController *rootController = [[JVMenuRootViewController alloc] init];

    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.navigationController];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[JVMenuHelper imageWithImage:[UIImage imageNamed:@"app_bg1.jpg"] scaledToWidth:self.window.frame.size.width]];
    self.window.contentMode = UIViewContentModeScaleAspectFit;

    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

```

## Requirements

## Installation

JVMenuPopover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "JVMenuPopover"

## Author

Jorge Valbuena, jorgevalbuena2@gmail.com

## License

JVMenuPopover is available under the MIT license. See the LICENSE file for more info.

