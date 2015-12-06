//
//  JVMenuPopoverView.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-14.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuPopoverView.h"
#import "JVMenuItems.h"
#import "UIImage+JVMenuCategory.h"


#pragma mark - Interface

@interface JVMenuPopoverView()

@property (nonatomic, strong) UIViewController *currentViewController;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIBlurEffect *blurEffect;

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;

@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;

@property (nonatomic) CGSize screenSize;

@property (nonatomic, assign) BOOL doneCellAnimations;

@property (nonatomic) NSInteger rowCount;

@property (nonatomic, assign) BOOL doneAnimations;

// Protected Methods
- (void)setupView;

@end


#pragma mark - Implementation

@implementation JVMenuPopoverView

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles` method instead." userInfo:nil];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles` method instead." userInfo:nil];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"Use the `initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles` method instead." userInfo:nil];
}


- (instancetype)initWithFrame:(CGRect)frame menuItems:(JVMenuItems *)menuItems
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _menuItems = menuItems;
        
        // checking if we have images or title for display
        if(_menuItems.menuImages.count == 0 || _menuItems.menuTitles.count == 0)
        {
            NSLog(@"Initializing JVMenuView without images or title may result on an empty menu.");
        }
        
        // setting up the view
        [self setupView];
    }
    
    return self;
}


- (void)setupView
{
    // setting up menu view
    if(self.frame.size.width == 0)
    {
        self.screenSize = [UIScreen mainScreen].bounds.size;
        self.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
    }
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.shadowView];
    [self addSubview:self.tableView];
    [self addSubview:self.closeBtn];
}


- (void)willMoveToWindow:(UIWindow *)newWindow
{
    self.doneCellAnimations = NO;
    [super willMoveToWindow:newWindow];
}


#pragma mark - Custom Accessors

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            // remove leading spaces
            _tableView.layoutMargins = UIEdgeInsetsZero;
        }
        
        _tableView.bounces = NO;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


- (UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(15, 28, self.menuItems.menuCloseButtonImage.size.width, self.menuItems.menuCloseButtonImage.size.height);
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setImage:self.menuItems.menuCloseButtonImage forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}


- (UIView *)shadowView
{
    if (!_shadowView)
    {
        _shadowView = [[UIView alloc] initWithFrame:self.frame];
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    
    return _shadowView;
}


- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.alpha = 0.0;
    }
    
    return _backgroundView;
}


- (UIBlurEffect *)blurEffect
{
    if(!_blurEffect)
    {
        _blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }
    
    return _blurEffect;
}


- (UIVisualEffectView *)blurEffectView
{
    if(!_blurEffectView)
    {
        _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:self.blurEffect];
        _blurEffectView.alpha = 0.6;
        _blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _blurEffectView.frame = self.frame;
    }
    
    return _blurEffectView;
}


- (UIVibrancyEffect *)vibrancyEffect
{
    if(!_vibrancyEffect)
    {
        _vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:self.blurEffect];
    }
    
    return _vibrancyEffect;
}


- (UIVisualEffectView *)vibrancyEffectView
{
    if(!_vibrancyEffectView)
    {
        _vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:self.vibrancyEffect];
        _vibrancyEffectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _vibrancyEffectView.frame = self.frame;
    }
    
    return _vibrancyEffectView;
}


#pragma mark - UITableView Delegate & Datasource

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // don't do anything if we are animating
    if(self.doneCellAnimations)
    {
        return;
    }
    
    if(self.menuItems.menuSlideInAnimation)
    {
        // slide in animations
        [self performSlideInCellAnimationsWithCell:cell forRowIndexPath:indexPath];
    }
    else if(self.menuItems.menuSlideInWithBounceAnimation)
    {
        // slide with bounce animations
        [self performSlideInWithBounceCellAnimationsWithCell:cell forRowIndexPath:indexPath];
    }
    else
    {
        // slide in default animations
        [self performSlideInCellAnimationsWithCell:cell forRowIndexPath:indexPath];
    }
}


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

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    // setting up rows
    if (indexPath.row == 0)
    {
        self.rowCount = 0;
        
        // setting first row
        if(self.menuItems.menuImages.count > 0)
        {
            [cell.imageView setImage:self.self.menuItems.menuImages[0]];
        }
        
        if(self.menuItems.menuTitles.count > 0)
        {
            cell.textLabel.text = self.menuItems.menuTitles[0];
        }
        
        self.rowCount++;
    }
    else if (indexPath.row == self.rowCount)
    {
        // setting second row
        if(self.menuItems.menuImages.count >= self.rowCount)
        {
            [cell.imageView setImage:self.menuItems.menuImages[self.rowCount]];
        }
        
        if(self.menuItems.menuTitles.count >= self.rowCount)
        {
            cell.textLabel.text = self.menuItems.menuTitles[self.rowCount];
        }
        
        self.rowCount++;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if([self.delegate respondsToSelector:@selector(menuPopoverDidSelectViewControllerAtIndexPath:)])
    {
        [self closeMenu];
        [self.delegate menuPopoverDidSelectViewControllerAtIndexPath:indexPath];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of sections in the tableview
    return self.menuItems.menuTitles.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // return the height of row
    return 70;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


#pragma mark - Cell animations

- (void)performSlideInCellAnimationsWithCell:(UITableViewCell *)cell forRowIndexPath:(NSIndexPath *)indexPath
{
    CGRect oldFrame = cell.frame;
    CGRect newFrame = CGRectMake(-cell.frame.size.width, cell.frame.origin.y, 0, cell.frame.size.height);
    
    // cell animations
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.0001f);
    cell.frame = newFrame;
    cell.alpha = 0;
    
    [UIView animateWithDuration:0.3/1.5
                          delay:0.10*indexPath.row
         usingSpringWithDamping:0.7
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // cell animations
                         cell.frame = oldFrame;
                         cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.0f);
                         cell.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         // getting the number of rows in section to avoid overlaps in animation when scrolling
                         NSInteger rows = [self.tableView numberOfRowsInSection:0];
                         
                         if(rows == indexPath.row+1)
                         {
                             self.doneCellAnimations = YES;
                         }
                     }];
}

- (void)performSlideInWithBounceCellAnimationsWithCell:(UITableViewCell *)cell forRowIndexPath:(NSIndexPath *)indexPath
{
    CGRect oldFrame = cell.frame;
    CGRect newFrame = CGRectMake(-cell.frame.size.width, cell.frame.origin.y, 0, cell.frame.size.height);
    
    // cell animations
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.0001f);
    cell.frame = newFrame;
    
    [UIView animateWithDuration:0.1
                          delay:0.2*indexPath.row
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         // animations
                         cell.frame = oldFrame;
                         cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.1f);
                     }
                     completion:^(BOOL finished) {
                         // nested animations
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.9f);
                                          }
                                          completion:^(BOOL finished) {
                                              // nested anomations
                                              [UIView animateWithDuration:0.1
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   // getting the number of rows in section to avoid overlaps in animation when scrolling
                                                                   NSInteger rows = [self.tableView numberOfRowsInSection:0];
                                                                   
                                                                   if(rows == indexPath.row+1)
                                                                   {
                                                                       self.doneCellAnimations = YES;
                                                                   }
                                                               }];
                                          }];
                     }];
}


#pragma mark - Show & Close menu

- (void)showMenuWithController:(UIViewController *)viewController
{
    if(self.doneAnimations)
    {
        return;
    }
    
    self.currentViewController = viewController;
    
    // spring animations
    [UIView animateWithDuration:0.15
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // animation
                         self.currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
                         //                         self.currentController.view.frame = CGRectMake(30, 100, 300, 500);
                         //                         self.currentController.view.clipsToBounds = YES;
                     } completion:^(BOOL finished) {
                         if(!finished)
                         {
                             return;
                         }
                         
                         self.backgroundView = [self snapshotViewAfterScreenUpdates:NO];
                         [self showBackgroundViewAnimated];
                         
                         //only apply the blur if the user hasn't disabled transparency effects
                         if(!UIAccessibilityIsReduceTransparencyEnabled())
                         {                             
                             [self insertSubview:self.blurEffectView atIndex:0];
                         }
                         
                         self.doneAnimations = YES;
                         self.closeBtn.alpha = 0.0;
                         self.alpha = 0.0;
                         
                         [[UIApplication sharedApplication].keyWindow addSubview:self];
                         
                         [UIView animateWithDuration:0.15
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.closeBtn.alpha = 1.0;
                                              self.alpha = 1.0;
                                              [self.tableView reloadData];
                                          } completion:nil];
                     }];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}


- (void)closeMenu
{
    // if we haven't finished show menu animations then return to avoid overlaps or interruptions
    if(!self.doneAnimations)
    {
        return;
    }
    
    [self removeFromSuperview];
    
    // resetting current visible controller scale & dimissing menu controller
    [UIView animateWithDuration:0.3/1.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         // animations
                         self.currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                     } completion:^(BOOL finished) {
                         // completion
                         self.doneAnimations = NO;
                         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                     }];
}


- (void)showBackgroundViewAnimated
{
    [UIView animateKeyframesWithDuration:0.1
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration
                              animations:^{
                                  self.backgroundView.alpha = 1.0;
                              }
                              completion:nil];
}

@end
