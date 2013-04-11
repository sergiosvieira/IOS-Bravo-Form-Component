//
//  BIFormModel.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormModel.h"

@implementation BIFormModel

- (NSArray *)sections
{
    if (!_sections)
    {
        if (info_)
        {
            int sections = [info_.allKeys count];
            NSArray *keys = info_.allKeys;
            NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:sections];
            
            for (int i = 0; i < sections; i++)
            {
                [tmp addObject:keys[i]];
            }
            
            _sections = [tmp copy];
        }
    }
    
    return _sections;
}

- (NSArray *)allFields
{
    if (!_allFields)
    {
        if (info_)
        {
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self.sections count]];
            
            for (int i = 0; i < [self.sections count]; i++)
            {
                int rows = [self numberOfRowsInSection:i];
                NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:rows];
                
                for (int j = 0; j < rows; j++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    NSArray *row = [self getRowAtIndexPath:indexPath];
                    
                    [values addObject:row[0]];
                }
                
                [array addObject:values];
            }
            
            _allFields = [array copy];
        }
    }
    
    return _allFields;
}

- (NSArray *)allValues
{
    if (!_allValues)
    {
        if (info_)
        {
            NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self.sections count]];
            
            for (int i = 0; i < [self.sections count]; i++)
            {
                int rows = [self numberOfRowsInSection:i];
                NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:rows];
                
                for (int j = 0; j < rows; j++)
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    NSArray *row = [self getRowAtIndexPath:indexPath];
                    
                    [values addObject:row[1]];
                }
                
                [array addObject:values];
            }
            
            _allValues = [array copy];
        }
    }
    
    return _allValues;
}

#pragma mark - Public Methods
- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    
    if (self)
    {
        info_ = info;
    }
    
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    if (info_)
    {
        NSAssert([info_.allValues[section] isKindOfClass:[NSArray class]], @"Invalid dictionary format. A NSArray is"
            " required!");
        
        NSArray *values = info_.allValues[section];
        
        result = [values count];
    }
    
    return result;
}

- (NSArray *)getRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([info_.allValues[indexPath.section] isKindOfClass:[NSArray class]], @"Invalid dictionary format. A NSArray is"
            " required!");
    
    int section = indexPath.section;
    int row = indexPath.row;
    
    NSArray *rows = info_.allValues[section];
    
    return rows[row];
}

- (void)setInfo:(NSDictionary *)info
{
    info_ = info;
    _allFields = nil;
    _allValues = nil;
}

@end
