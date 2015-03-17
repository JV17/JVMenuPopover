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
    }
    
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.tableView];
}


#pragma mark - TableView getter & setter

-(UITableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
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
    return 60;
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
    return 100;
}

@end