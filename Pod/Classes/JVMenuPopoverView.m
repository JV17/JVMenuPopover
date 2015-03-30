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

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic) CGSize screenSize;
@property (nonatomic, assign) BOOL doneCellAnimations;
@property (nonatomic) NSInteger numRows;

// Protected Methods
- (void)setup;

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
        
        _tableView.bounces = YES;
        _tableView.scrollEnabled = YES;
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
    
    if(self.doneCellAnimations)
        return;
    
    CGRect oldFrame = cell.frame;
    CGRect newFrame = CGRectMake(0, cell.frame.origin.y, 0, cell.frame.size.height);
    
    // cell animations
    cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.0001f);
    cell.frame = newFrame;
    
    [UIView animateWithDuration:0.3/1.5
                          delay:0.3*indexPath.row
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.1f);
                         cell.frame = oldFrame;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3/2
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              cell.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95f, 0.9f);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.3/2
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
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    if(indexPath.row == 0)
    {
        // set first row
        cell.textLabel.text = @"        JVMenu rows";
    }
    else
    {
        // set the rest of the rows
        cell.textLabel.text = @"        JVMenu rows";
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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // return the height of row
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // custom view for header. will be adjusted to default or specified header height
//    if(!_headerView)
//    {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 50, 50)];
//        _headerView.backgroundColor = [UIColor clearColor];
//    }
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - TableViewCell helper functions



@end