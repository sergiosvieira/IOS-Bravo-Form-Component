//
//  BIFormViewController.h
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIFormTableViewController.h"

@interface BIFormViewController : UIViewController
<
    UITableViewDelegate
>
{
@private
    NSMutableDictionary *buttons;
    NSMutableArray *views;
    int footerHeight;
}

#pragma mark - Lazy Properties
@property (nonatomic, strong) BIFormTableViewController *tableController;
@property (assign, nonatomic) BOOL isVisibleSectionTitle;

#pragma mark - Public Methods
- (id)initWithInfo:(NSDictionary *)info;
- (void)setInfo:(NSDictionary *)info;
- (void)addButton:(UIButton *)button inSection:(int)section;
- (void)addLabel:(UILabel *)label inSection:(int)section;
- (void)setEditable:(BOOL)editable;

@end
