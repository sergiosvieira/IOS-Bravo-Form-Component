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

#pragma mark - Lazy Properties
@property (nonatomic, strong) BIFormTableViewController *tableController;

#pragma mark - Public Methods
- (id)initWithInfo:(NSDictionary *)info;
- (void)setInfo:(NSDictionary *)info;

@end
