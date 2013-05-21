//
//  BIFormViewController.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormViewController.h"
#import "BIFormModel.h"

#define CELL_HEIGHT  44.f

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

- (void)setIsVisibleSectionTitle:(BOOL)isVisibleSectionTitle
{
    self.tableController.isVisibleSectionTitle = isVisibleSectionTitle;
}

- (BOOL)isVisibleSectionTitle
{
    return self.tableController.isVisibleSectionTitle;
}

- (void)setEditable:(BOOL)editable
{
    [self.tableController setEditable:editable];
}

#pragma mark - Private Methods
- (void)initialize
{
    /** initialize **/
    self.isVisibleSectionTitle = NO;
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
    #ifdef BRAVO_FORM_BUTTON_PADDING
        return footerHeight + BRAVO_FORM_BUTTON_PADDING;
    #else
        return footerHeight;
    #endif
}

 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [views count] > 0 ? views[section] : nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *row = [self.tableController.modelController getRowAtIndexPath:indexPath];
    NSNumber *type = [self.tableController.modelController getTypeAtIndexPath:indexPath];
    
    if ([type intValue] == BUTTON)
    {
        // 0 = Title, 1 = default value, 2 = type, 3 = target, 4 = action (nsstring)
        NSObject *obj = row[3];
        
        SEL selector = NSSelectorFromString(row[4]);
        
        if ([obj respondsToSelector:selector])
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:selector withObject:obj];
            #pragma clang diagnostic pop
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSArray *row = [self.tableController.modelController getRowAtIndexPath:indexPath];
    NSNumber *type = [self.tableController.modelController getTypeAtIndexPath:indexPath];
    
    if ([type intValue] == STRING_WITH_BUTTON)
    {
        // 0 = Title, 1 = default value, 2 = type, 3 = target, 4 = action (nsstring)
        NSObject *obj = row[3];
        
        SEL selector = NSSelectorFromString(row[4]);
        
        if ([obj respondsToSelector:selector])
        {
            BIFormViewCell *cell = (BIFormViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            NSString *text = cell.tfField.text;
            
            cell.tfField.text = @"";
            
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj performSelector:selector withObject:text withObject:indexPath];
            #pragma clang diagnostic pop
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat height = CELL_HEIGHT;
    NSArray *array = [self.tableController.modelController getRowAtIndexPath:indexPath];
    NSNumber *type = array[2];
    
    if ([type intValue] == CUSTOM)
    {
        UIView *view = (UIView *)array[3];
        
        SEL selector = NSSelectorFromString(array[4]);
        
        if ([view respondsToSelector:selector])
        {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [view performSelector:selector];
            #pragma clang diagnostic pop
        }
        
        height = view.frame.size.height + 10.f;
        
        if (height < CELL_HEIGHT)
        {
            height = CELL_HEIGHT;
        }
    }
    
//    if ([self.options[indexPath.section][indexPath.row][1] isEqualToString:@"taglist"])
//    {
//        [self.tagList display];
//        height = self.tagList.fittedSize.height + 10;
//    }
    
    return height;
}
@end
