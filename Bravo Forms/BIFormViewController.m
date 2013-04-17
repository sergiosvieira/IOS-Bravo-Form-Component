//
//  BIFormViewController.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormViewController.h"
#import "BIFormModel.h"

@interface BIFormViewController (Hidden)

- (void)initialize;

@end

@implementation BIFormViewController

- (BIFormTableViewController *)tableController
{
    if (!_tableController)
    {
        _tableController = [[BIFormTableViewController alloc] initWithNibName:@"BIFormTableViewController" bundle:nil];
    }
    
    return _tableController;
}

#pragma mark - Init
- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    
    if (self)
    {
        [self.tableController.modelController setInfo:info];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public Methods
- (void)setInfo:(NSDictionary *)info
{
    [self.tableController.modelController setInfo:info];
}

- (void)addButton:(UIButton *)button inSection:(int)section
{
    CGFloat padding = 0.f;
    
    #ifdef BRAVO_FORM_BUTTON_PADDING
        padding = BRAVO_FORM_BUTTON_PADDING;
    #endif
    
    CGRect frame;
    UIView *view;
    NSNumber *objSection = [NSNumber numberWithInt:section];
    int sections =  [self.tableController.modelController.sections count];
    
    NSAssert(section < sections, @"Error: section index out of bounds!");
    
    NSMutableArray *array = buttons[objSection];
        
    if (!array)
    {
        CGRect scrFrame = [[UIScreen mainScreen] applicationFrame];
        buttons[objSection] = [[NSMutableArray alloc] init];
        view = [[UIView alloc] initWithFrame:scrFrame];
        [views addObject:view];
    }
    
    UIButton *lastButton = (UIButton *)[array lastObject];
    
    if (!lastButton)
    {
        frame = button.frame;
        frame.origin.y = 0.f + padding;
        button.frame = frame;
    }
    else
    {
        frame = lastButton.frame;
        frame.origin.y += frame.size.height + padding;
        button.frame = frame;
    }
    
    array = buttons[objSection];
    [array addObject:button];
    footerHeight += button.frame.size.height + padding;
    view = views[section];
    frame = view.frame;
    frame.size.height = footerHeight;
    view.frame = frame;
    [view addSubview:button];
}

#pragma mark - Private Methods
- (void)initialize
{
    /** initialize **/
    footerHeight = 0;
    buttons = [[NSMutableDictionary alloc] init];
    views = [[NSMutableArray alloc] init];
    self.tableController.tableView.delegate = self;
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.tableController.view.frame  = frame;

    /** BIFormTableViewController **/
    [self.view addSubview:self.tableController.view];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return footerHeight + BRAVO_FORM_BUTTON_PADDING;
}

 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return views[section];
}

@end
