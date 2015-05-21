# JVMenuPopover [![Version](https://img.shields.io/cocoapods/v/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover) [![License](https://img.shields.io/cocoapods/l/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover) [![Platform](https://img.shields.io/cocoapods/p/JVMenuPopover.svg?style=flat)](http://cocoadocs.org/docsets/JVMenuPopover)

This is a simple menu controller where I tried to simulate the native iOS animation of switching between apps. It can be used in many different ways and you can also customize it to use your own animations.

### Preview 1 - Menu with Background pic

<a href="http://www.youtube.com/watch?feature=player_embedded&v=PeAu5T2dbAk?autoplay=1" target="_blank">![screenshot-1](Previews/menu_with_bgpic.gif)</a>

### Preview 2 - Menu without Background pic

<a href="http://www.youtube.com/watch?feature=player_embedded&v=zcLHQHAZeU8?autoplay=1" target="_blank">![screenshot-1](Previews/menu_with_nobgpic.gif)</a>

### Preview 3 - Menu with Vibrancy

<a href="http://www.youtube.com/watch?feature=player_embedded&v=_9OrMZ7VYDI?autoplay=1" target="_blank">![screenshot-1](Previews/menu_with_vibrancy.gif)</a>

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Using JVMenuPopover with your own project.

* Set your RootViewController in the your AppDelegate.m, you could follow my example project and see how I set a background image to the entire app if you are looking to follow the same approach. Also, notice that I am able to set the navigation bar transparent just setting the boolean I have created for it. 
    
    * I use one of my helper functions in the pods to adjust the image to my device width and not show an expanded image.
    
```objc 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.rootViewController = [[JVMenuRootViewController alloc] init];

    // setting up navigation controller with root controller & transparent nav bar
    self.navigationController = [[JVMenuNavigationController alloc] initWithRootViewController:self.rootViewController];
    self.navigationController.withTransparentNavBar = YES;

    // setting up app window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.navigationController];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[JVMenuHelper imageWithImage:[UIImage imageNamed:@"app_bg1.jpg"] scaledToWidth:self.window.frame.size.width]];
    self.window.contentMode = UIViewContentModeScaleAspectFit;

    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}
```

* Here, I set my menu controller with the images I would like to display as icon images, the title for my menu and close menu image. I use a technique known as Lazy Loading which allows me to create my menu at the last minute before adding it to the view. 
    
    * Currently, I am using some regular free images I have added to the same project, but you do this within your root controller and you can load whatever images you want to. Also, the menu will create rows only base on the labels/titles provided and not from how many images you give it to the menu.

```objc
- (JVMenuPopoverViewController *)menuController
{
    if(!_menuController)
    {
        _menuController = [[JVMenuPopoverViewController alloc] initWithImages:@[[UIImage imageNamed:@"home-48"],
                                                                                [UIImage imageNamed:@"about-48"],
                                                                                [UIImage imageNamed:@"settings-48"],
                                                                                [UIImage imageNamed:@"business_contact-48"],
                                                                                [UIImage imageNamed:@"ask_question-48"]]
                                                                        titles:@[@"Home",
                                                                                 @"About Us",
                                                                                 @"Our Service",
                                                                                 @"Contact Us",
                                                                                 @"Help?"]
                                                                    closeImage:[UIImage imageNamed:@"cancel_filled-50"]];
        _menuController.delegate = self;
        _menuController.slideInWithBounceAnimation = YES; // choose our animation type
    }

    return _menuController;
}
```

* Then, we set our navigation controller, however we wanted it to be displayed.
    
    * Here, I set the menu image I want to display, the color of the menu button.

```objc
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.navigationController.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.menuImg style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
}
```

* Finally but not least, I set the showing menu controller from our root controller. Also, we need to implement the close menu button delegate to dismiss the menu and get back to our previous controller. And the setNewViewController delegate which I tell my own navigation controller to handle all the display and animations for presenting new controllers.

```objc
// showing menu from our root controller
- (void)showMenu
{
    [self.menuController showMenuFromController:self];
}

// closing menu when close button is pressed
- (void)closeMenu:(JVMenuPopoverViewController *)JVMenuPopoverViewController
{
    [self.navigationController popToViewController:JVMenuPopoverViewController animated:NO];
}

// setting the view controllers to be presented
- (void)setNewViewController:(UINavigationController *)navController fromIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        self.mainController = [[JVMenuRootViewController alloc] init];
        [self.navigationController setViewControllers:@[self.mainController]];
    }
    else if(indexPath.row == 1)
    {
        self.secondController = [[JVMenuSecondController alloc] init];
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

Contact me if you find any bugs or potential room for improvements, which I am sure there are. Jorge Valbuena (@JV17), jorgevalbuena2@gmail.com. BTW! You are welcome to help in supporting this pod or making improvements to it.

## License

JVMenuPopover is available under the MIT license. See the LICENSE file for more info.

