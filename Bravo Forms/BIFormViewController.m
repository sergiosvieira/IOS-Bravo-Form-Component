//
//  BIFormViewController.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormViewController.h"

@interface BIFormViewController ()

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

#pragma mark - Private Methods
- (void)initialize
{
    /** BIFormTableViewController **/
    [self.view addSubview:self.tableController.view];
}

@end
