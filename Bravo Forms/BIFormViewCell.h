//
//  BIFormViewCell.h
//  Bravo Forms
//
//  Created by Paulo Pinheiro on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIFormViewCell : UITableViewCell

#pragma mark - Lazy Properties
@property (strong, nonatomic) UILabel *lbCaption;
@property (strong, nonatomic) UITextField *tfField;

#pragma mark - Public Methods
- (void)defaultLabelPosition;
- (void)centerLabelPosition;
- (void)buttonLabelPosition;

@end
