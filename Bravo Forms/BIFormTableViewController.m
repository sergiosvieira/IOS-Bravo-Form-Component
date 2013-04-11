//
//  BIFormTableViewController.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormTableViewController.h"
#import "UITextField+Identify.h"

@implementation BIFormTableViewController

- (BIFormModel *)modelController
{
    if (!_modelController)
    {
        _modelController = [[BIFormModel alloc] init];
    }
    
    return _modelController;
}

#pragma mark - Init
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.modelController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.modelController numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BIFormViewCell";
    
    BIFormViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[BIFormViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.tfField.delegate = self;
    }
    
    [self configureCell:cell withModel:self.modelController withIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.modelController.sections[section];
}

#pragma mark - Private Methods
- (void)configureCell:(BIFormViewCell *)cell withModel:(BIFormModel *)model withIndexPath:(NSIndexPath *)indexPath
{
    [cell.lbCaption setText:self.modelController.allFields[indexPath.section][indexPath.row]];
    [cell.tfField setText:self.modelController.allValues[indexPath.section][indexPath.row]];
    cell.tfField.indexPath = indexPath;
}

- (NSIndexPath *) nextIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *nextIndexPath;
    
    int nextSection = indexPath.section;
    int nextRow = indexPath.row + 1;
    int numOfRows = [self.tableView numberOfRowsInSection:indexPath.section];
    
    if (nextRow >= numOfRows)
    {
        nextSection = (indexPath.section + 1) % [self numberOfSectionsInTableView:self.tableView];
        nextRow = 0;
    }
    
    nextIndexPath = [NSIndexPath indexPathForRow:nextRow inSection:nextSection];
    
    return nextIndexPath;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int section = textField.indexPath.section;
    int row = textField.indexPath.row;
    
    self.modelController.allValues[section][row] = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *currentIndexPath = textField.indexPath;
    NSIndexPath *nextIndexPath = [self nextIndexPath:currentIndexPath];

    if (nextIndexPath.section == 0 && nextIndexPath.row == 0)
    {
        [self.view endEditing:YES];
    }
    else
    {
        [self.tableView scrollToRowAtIndexPath:nextIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

        BIFormViewCell *nextCell = (BIFormViewCell *)[self.tableView cellForRowAtIndexPath:nextIndexPath];
       
        [nextCell.tfField becomeFirstResponder];
    }
    
    return YES;
}

@end
