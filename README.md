# JVMenuPopover [![Version](https://img.shields.io/cocoapods/v/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover) [![License](https://img.shields.io/cocoapods/l/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover) [![Platform](https://img.shields.io/cocoapods/p/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover)

This is a simple menu controller where I tried to simulate the native iOS animation of switching between apps. It can be used in many different ways and you can also customize it to use your own animations.

## Previews

###### • Menu with slideInWithBounceAnimation

<a href="http://www.youtube.com/watch?feature=player_embedded&v=ySgPzJJSCAg?autoplay=1" target="_blank">![screenshot-1](Previews/jvmenu.preview1.gif)</a>

###### • Menu with slideInAnimation

<a href="http://www.youtube.com/watch?feature=player_embedded&v=2MG6kVMMuTo?autoplay=1" target="_blank">![screenshot-1](Previews/jvmenu.preview2.gif)</a>

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Using JVMenuPopover with your own project.

* In your function `application: didFinishLaunchingWithOptions:` we need to setup our `UIWindow`, `JVMenuNavigationController` and your root view controller. Feel free to follow my project sample implementation where I use lazy intialization for these objects. 
    
    * Also, it's important to set a background image to our `UIWindow` to be able to achieve the our menu effect with a background image.
    
```objc 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // setting up app window
    [self setupCustomWindow];

    return YES;
}

#pragma mark - Custom Accessors

- (JVMenuRootViewController *)rootViewController
{
    if (!_rootViewController)
    {
        _rootViewController = [[JVMenuRootViewController alloc] init];
    }

    return _rootViewController;
}


- (JVMenuNavigationController *)navigationController
{
    if (!_navigationController)
    {
        _navigationController = [[JVMenuNavigationController alloc] initWithRootViewController:self.rootViewController transparentNavBar:YES];
    }

    return _navigationController;
}


#pragma mark - UIWindow Customization

- (void)setupCustomWindow
{
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = self.navigationController;
    self.window.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"app_bg1.jpg"] imageScaledToWidth:self.window.frame.size.width]];

    [self.window makeKeyAndVisible];
    [self.window addSubview:self.navigationController.view];
}
```

* Then, we need to set our data model for our menu using the class `JVMenuItems` which holds all the menu images, titles and the close button image to display. Also, we can set our preferred menu animation. And we need to create the `JVMenuPopoverView` which is the actual menu with the menu items. Note: The same approach here the use of lazy intialization.

```objc
- (JVMenuItems *)menuItems
{
    if(!_menuItems)
    {
        _menuItems = [[JVMenuItems alloc] initWithMenuImages:@[[UIImage imageNamed:@"home-48"],
                                                               [UIImage imageNamed:@"about-48"],
                                                               [UIImage imageNamed:@"settings-48"],
                                                               [UIImage imageNamed:@"business_contact-48"],
                                                               [UIImage imageNamed:@"ask_question-48"]]
                                                  menuTitles:@[@"Home",
                                                               @"About Us",
                                                               @"Our Service",
                                                               @"Contact Us",
                                                               @"Help?"]
                                         menuCloseButtonImage:[UIImage imageNamed:@"cancel_filled-50"]];
        _menuItems.menuSlideInAnimation = YES; 
    }

    return _menuItems;
}

- (JVMenuPopoverView *)menuPopover
{
    if(!_menuPopover)
    {
        _menuPopover = [[JVMenuPopoverView alloc] initWithFrame:self.view.frame menuItems:self.menuItems];
        _menuPopover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _menuPopover.delegate = self;
    }

    return _menuPopover;
}
```


* Then, we need to set our menu bar button with our preferred image and set the target to show the menu.

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];

    // creating menu
    self.menuPopover = [self menuPopover];

    // setting up menu bar button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_black-48"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
}
```

* Finally, we set our menu bar button to target to call the `JVMenuPopoverView` helper function and our menu delegate to know which menu item was selected by the user and present a new view controller or whatever you would like to then.

```objc
#pragma mark - Menu Helper Functions

- (void)showMenu
{
    [self.menuPopover showMenuWithController:self];
}


#pragma mark - Menu Delegate

- (void)menuPopoverDidSelectViewControllerAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [self.navigationController setViewControllers:@[self]];
    }
    else if(indexPath.row == 1)
    {
        [self.navigationController setViewControllers:@[self.secondController]];
    }
}
```

## Requirements

Developed and tested using iOS8+

## Installation

JVMenuPopover is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "JVMenuPopover"

## Author & Support

Contact me if you find any bugs or potential room for improvements, which I am sure there are. Jorge Valbuena (@JV17), jorge.valbuena@jorgedeveloper.com. BTW! You are welcome to help in supporting this pod or making improvements to it.

## License

JVMenuPopover is available under the MIT license. See the LICENSE file for more info.

## Release Notes

#### Version 1.3

* Added landscape support. Please be advise that you might need to provide a bigger image allow the background to show properly.

