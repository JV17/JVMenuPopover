//
//  JVMenuPopoverView.m
//  JVMenuPopover
//
//  Created by Jorge Valbuena on 2015-03-14.
//  Copyright (c) 2015 Jorge Valbuena. All rights reserved.
//

#import "JVMenuPopoverView.h"
#import <JVMenuHelper.h>

#pragma mark - Interface
@interface JVMenuPopoverView()

@property (nonatomic) CGSize screenSize;
@property (nonatomic, assign) BOOL doneCellAnimations;
@property (nonatomic) NSInteger rowCount;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *titles;

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

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles
{
    if(!(self = [super initWithFrame:frame]))
        return nil;
    
    // first we need to get the images and titles to provide a check in our
    self.images = images;
    self.titles = titles;
    
    // checking if we have images or title for display
    if(self.images.count == 0 || self.titles.count == 0)
    {
        NSLog(@"Initializing JVMenuView without images or title may result on an empty menu.");
    }
    
    // setting up the view
    [self setupView];
    
    return self;
}

- (void)setupView
{
    // setting up menu view
    if(self.frame.size.width == 0)
    {
        self.screenSize = [JVMenuHelper getScreenSize];
        self.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height);
    }
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.tableView];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    self.doneCellAnimations = NO;
    [super willMoveToWindow:newWindow];
}

#pragma mark - TableView getter & setter

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


#pragma mark - UITableView Delegate & Datasource

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // do something after display
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // don't do anything if we are animating
    if(self.doneCellAnimations)
        return;
    
    if(self.slideInAnimation)
    {
        // slide in animations
        [self performSlideInCellAnimationsWithCell:cell forRowIndexPath:indexPath];
    }
    else if(self.slideInWithBounceAnimation)
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
        if(self.images.count > 0)
            [cell.imageView setImage:self.images[0]];
        
        if(self.titles.count > 0)
            cell.textLabel.text = self.titles[0];
        
        self.rowCount++;
    }
    else if (indexPath.row == self.rowCount)
    {
        // setting second row
        if(self.images.count >= self.rowCount)
            [cell.imageView setImage:self.images[self.rowCount]];
        
        if(self.titles.count >= self.rowCount)
            cell.textLabel.text = self.titles[self.rowCount];
        
        self.rowCount++;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if([self.delegate respondsToSelector:@selector(menuPopover:didSelectRowAtIndexPath:)])
    {
        [self.delegate menuPopover:self didSelectRowAtIndexPath:indexPath];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of sections in the tableview
    return self.titles.count;
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

@end