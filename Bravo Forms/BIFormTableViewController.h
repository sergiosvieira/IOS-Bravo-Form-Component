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
    UITextFieldDelegate
>

#pragma mark - Lazy Properties
@property (nonatomic, strong) BIFormModel *modelController;

@end
