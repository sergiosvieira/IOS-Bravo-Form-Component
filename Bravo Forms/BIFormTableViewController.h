//
//  BIFormTableViewController.h
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIFormModel.h"
#import "BIFormViewCell.h"

@interface BIFormTableViewController : UITableViewController
<
    UITableViewDelegate,
    UITextFieldDelegate,
    UIPickerViewDelegate
>
{
@private
    UITextField *selectedTextField;
    BOOL isEditable;
}

#pragma mark - Lazy Properties
@property (nonatomic, strong) BIFormModel *modelController;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *picker;
@property (assign, nonatomic) BOOL isVisibleSectionTitle;

#pragma mark - Public Methods
- (void)setEditable:(BOOL)editable;

@end
