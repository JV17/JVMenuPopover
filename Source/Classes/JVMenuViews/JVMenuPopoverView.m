//
//  JVMenuPopoverView.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-14.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "JVMenuPopoverView.h"
#import "JVMenuItems.h"
#import "UIImage+JVMenuCategory.h"
#import "UIScreen+JVMenuCategory.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#pragma mark - Interface

@interface JVMenuPopoverView()

@property (nonatomic, weak) UIViewController *currentViewController;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UIView *shadowView;

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIBlurEffect *blurEffect;

@property (nonatomic, strong) UIVisualEffectView *blurEffectView;

@property (nonatomic, strong) UIVisualEffectView *vibrancyEffectView;

@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;

@property (nonatomic) CGSize screenSize;

@property (nonatomic, assign) BOOL doneCellAnimations;

@property (nonatomic) NSInteger rowCount;

@property (nonatomic, assign) BOOL doneAnimations;

- (void)setupView;

@end


static CGFloat const kTransformToValue = 0.6;


#pragma mark - Implementation

@implementation JVMenuPopoverView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero menuItems:nil];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame menuItems:nil];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setupView];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame menuItems:(JVMenuItems *)menuItems
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _menuItems = menuItems;
        
        if(!_menuItems.menuImages.count || !_menuItems.menuTitles.count)
        {
            NSLog(@"Initializing JVMenuView without images or title may result on an empty menu.");
        }
        
        [self setupView];
    }
    
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)setupView
{
    if (!_menuItems)
    {
        return;
    }

    if(self.frame.size.width == 0)
    {
        self.screenSize = [UIScreen mainScreen].bounds.size;
        self.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
    }
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.shadowView];
    [self addSubview:self.tableView];
    [self addSubview:self.closeBtn];
    
    [self addObservers];
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
        _tableView = [[UITableView alloc] initWithFrame:self.tableViewFrame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
        {
            // remove leading spaces
            _tableView.layoutMargins = UIEdgeInsetsZero;
        }
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


- (CGRect)tableViewFrame
{
    return CGRectMake(0, 70, self.frame.size.width, self.frame.size.height);
}


- (UIButton *)closeBtn
{
    if(!_closeBtn)
    {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = self.closeBtnFrame;
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setImage:self.menuItems.menuCloseButtonImage forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}


- (CGRect)closeBtnFrame
{
    return CGRectMake(15, 28, self.menuItems.menuCloseButtonImage.size.width, self.menuItems.menuCloseButtonImage.size.height);
}


- (UIView *)shadowView
{
    if (!_shadowView)
    {
        _shadowView = [[UIView alloc] initWithFrame:self.shadowViewFrame];
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }
    
    return _shadowView;
}


- (CGRect)shadowViewFrame
{
    return self.frame;
}


- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.backgroundImageViewFrame];
        _backgroundImageView.alpha = 0.0;
    }
    
    return _backgroundImageView;
}


- (CGRect)backgroundImageViewFrame
{
    return self.frame;
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
        _blurEffectView.frame = self.blurEffectViewFrame;
    }
    
    return _blurEffectView;
}


- (CGRect)blurEffectViewFrame
{
    return self.frame;
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


- (void)setMenuItems:(JVMenuItems *)menuItems
{
    _menuItems = menuItems;
    
    if (self.menuItems && (self.menuItems.menuImages.count || self.menuItems.menuTitles.count))
    {
        [self setupView];
    }
}


#pragma mark - UITableView Delegate & Datasource

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.doneCellAnimations)
    {
        return;
    }
    
    if(self.menuItems.menuSlideInAnimation)
    {
        [self performSlideInCellAnimationsWithCell:cell forRowIndexPath:indexPath];
    }
    else if(self.menuItems.menuSlideInWithBounceAnimation)
    {
        [self performSlideInWithBounceCellAnimationsWithCell:cell forRowIndexPath:indexPath];
    }
    else
    {
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
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    if (indexPath.row == 0)
    {
        self.rowCount = 0;
        
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
    return self.menuItems.menuTitles.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.0001f);
    cell.frame = newFrame;
    cell.alpha = 0;
    
    [UIView animateWithDuration:0.3/1.5
                          delay:0.10*indexPath.row
         usingSpringWithDamping:0.7
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         cell.frame = oldFrame;
                         cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.0f);
                         cell.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
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
    
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.0001f);
    cell.frame = newFrame;
    
    [UIView animateWithDuration:0.1
                          delay:0.2*indexPath.row
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         cell.frame = oldFrame;
                         cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.1f);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.9f);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
                                                               }
                                                               completion:^(BOOL finished) {
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
    
    [UIView animateWithDuration:0.15
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{

                         self.currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kTransformToValue, kTransformToValue);
                         
                     }
                     completion:^(BOOL finished) {
                         if(!finished)
                         {
                             return;
                         }
                         
                         self.backgroundImageView.image = [UIImage screenShotFromWindow];
                         [self showBackgroundImageViewAnimated];
                         
                         if(!UIAccessibilityIsReduceTransparencyEnabled())
                         {                             
                             [self insertSubview:self.blurEffectView aboveSubview:self.shadowView];
                         }
                         
                         [[UIApplication sharedApplication].keyWindow addSubview:self];
                         
                         self.doneAnimations = YES;
                         self.closeBtn.alpha = 0.0;
                         self.alpha = 0.0;
                         
                         [UIView animateWithDuration:0.15
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.closeBtn.alpha = 1.0;
                                              self.alpha = 1.0;
                                              [self.tableView reloadData];
                                          }
                                          completion:^(BOOL finished) {
                                              // this fixes issue when the device rotates while the menu is showing and then the menu is dismissed.
                                              self.currentViewController.view.transform = CGAffineTransformIdentity;
                                          }];
                     }];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}


- (void)closeMenu
{
    if(!self.doneAnimations)
    {
        return;
    }
    
    // we need to reset the previous state of the controller in the background.
    self.currentViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kTransformToValue, kTransformToValue);
    
    [self removeFromSuperview];
    
    [UIView animateWithDuration:0.3/1.5
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         self.currentViewController.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         self.doneAnimations = NO;
                         [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
                     }];
}


- (void)showBackgroundImageViewAnimated
{
    [UIView animateKeyframesWithDuration:0.1
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration
                              animations:^{
                                  self.backgroundImageView.alpha = 1.0;
                              }
                              completion:nil];
}


#pragma mark - Observers

- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}


- (void)didDeviceOrientationChange:(NSNotification *)notification
{
    CGSize screenSize = [UIScreen screenSize];
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    [UIView animateWithDuration:0.3
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundImageView.frame = self.backgroundImageViewFrame;
                         self.shadowView.frame = self.shadowViewFrame;
                         self.tableView.frame = self.tableViewFrame;
                         self.closeBtn.frame = self.closeBtnFrame;
                         self.blurEffectView.frame = self.blurEffectViewFrame;
                     } completion:nil];
}

@end
