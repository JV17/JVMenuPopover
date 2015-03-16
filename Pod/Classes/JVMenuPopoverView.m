//
//  JVMenuPopoverView.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-14.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuPopoverView.h"

#pragma mark - Interface
@interface JVMenuPopoverView()

// Private Properties
@property (nonatomic) CGSize screenSize;
@property (nonatomic, assign) BOOL doneAnimations;
@property (nonatomic) int dummyCtr;// TODO: remove this!

// Private Methods
- (void)setup;
- (UIViewController *)topViewController;
- (UIViewController *)topViewController:(UIViewController *)rootViewController;

@end


#pragma mark - Implementation
@implementation JVMenuPopoverView

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        // set view
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        // set view
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.screenSize = [self getScreenSize];
    [self addSubview:self.tableView];
}


#pragma mark - TableView getter & setter

-(UITableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.screenSize.width, self.screenSize.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            // remove leading spaces
            _tableView.layoutMargins = UIEdgeInsetsZero;
        }
        
        _tableView.bounces = YES;
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


#pragma mark - UITableView Delegate & Datasource

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    // setups cell
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:16];
//    cell.textLabel.textColor = FlatGray;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if(indexPath.row == 0)
    {
        // set first row
        cell.textLabel.text = @"first row";
    }
    else
    {
        // set the rest of the rows
        cell.textLabel.text = @"other rows";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of sections in the tableview
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // return the height of row
    return 30;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // do any changes to the cells before displaying them / after they are created
}

-(void)insertNewRowToTableView
{
    // inserts a new in our tableview
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}


#pragma mark - show menu

- (void)showMenu
{
    UIViewController *currentController = [self topViewController];
    
    if(self.dummyCtr == 0)
    {
        [UIView animateWithDuration:0.15 animations:^{
            currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.73, 0.73);
            //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.73, 0.73);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1/3 animations:^{
                currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1/3 animations:^{
                    currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75);
                    //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1/3 animations:^{
                        currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                        //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
                    } completion:^(BOOL finished) {
                        if(finished)
                        {
                            self.doneAnimations = YES;
                        }
                    }];
                }];
            }];
        }];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        self.dummyCtr = 1;
    }
    else
    {
        if(!self.doneAnimations)
            return;
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            currentController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
            if(finished) // TODO: remove this or move to bottmo animation
            {
                self.doneAnimations = NO;
            }
            [UIView animateWithDuration:0.2/4 animations:^{
                //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15/4 animations:^{
                    //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.15/4 animations:^{
                        //self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                    }];
                }];
            }];
        }];
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        self.dummyCtr = 0;
    }
}


#pragma mark - Helper functions

- (CGSize)getScreenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
    {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    
    return screenSize;
}

- (UIViewController *)topViewController
{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil)
    {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

@end