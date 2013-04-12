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

- (UIPickerView *)picker
{
    if (!_picker)
    {
        _picker = [[UIPickerView alloc] init];
    }
   
    return _picker;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];       
    }
   
    return _datePicker;
}

#pragma mark - Init
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
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
- (void)initialize
{
    /** UIPickerView **/
    self.picker.delegate = self;
}

- (void)configureCell:(BIFormViewCell *)cell withModel:(BIFormModel *)model withIndexPath:(NSIndexPath *)indexPath
{
    /** cell label **/
    [cell.lbCaption setText:self.modelController.allFields[indexPath.section][indexPath.row]];
    
    /** cell field **/
    [cell.tfField setText:self.modelController.allValues[indexPath.section][indexPath.row]];
    cell.tfField.indexPath = indexPath;
    cell.tfField.type = [self.modelController getTypeAtIndexPath:indexPath];
    
    switch ([cell.tfField.type intValue])
    {
        case DATE:
            cell.tfField.inputView = self.datePicker;
        break;
        case OPTION:
            cell.tfField.inputView = self.picker;
        break;
    }
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL result = NO;
    BOOL containsReadOnly;
    BOOL containsNumeric;
    NSNumber *date = [NSNumber numberWithInt:DATE];
    NSNumber *option = [NSNumber numberWithInt:OPTION];
    NSNumber *number = [NSNumber numberWithInt:NUMBER];
    NSArray *readOnlyFields = @[
        date,
        option
    ];
    NSArray *numericFields = @[
        number
    ];
    
    containsReadOnly = [readOnlyFields containsObject:textField.type];
    containsNumeric = [numericFields containsObject:textField.type];
    
    if (!containsReadOnly && containsNumeric)
    {
        // accepting only numbers
        NSCharacterSet *onlyNumeric = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:string];
        
        if ([onlyNumeric isSupersetOfSet:stringSet])
        {
            result = YES;
        }
    }
    else
    {
        // is read only field
        result = !containsReadOnly;
    }

    return result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    selectedTextField = textField;
    
    switch ([textField.type integerValue])
    {
        case DATE:
        
        break;
        
        case OPTION:
        
        break;
    }
}

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

#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *options = [self.modelController getOptionValuesAtIndexPath:selectedTextField.indexPath];
    
    return [options count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *options = [self.modelController getOptionValuesAtIndexPath:selectedTextField.indexPath];

    return options[row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row != 0)
    {
        NSArray *options = [self.modelController getOptionValuesAtIndexPath:selectedTextField.indexPath];
        
        [selectedTextField setText:options[row]];
    }
}

#pragma mark - Selectors
- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];//@"dMMMyyyy h:mm:ss a"];
    NSString *date = [dateFormat stringFromDate:datePicker.date ];
   
    [selectedTextField setText:date];
}

@end
