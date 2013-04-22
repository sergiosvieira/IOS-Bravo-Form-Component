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

- (NSNumber *)getTypeAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([info_.allValues[indexPath.section] isKindOfClass:[NSArray class]], @"Invalid dictionary format. A NSArray is"
        " required!");
    
    NSArray *row = [self getRowAtIndexPath:indexPath];
    
    NSAssert([row[2] isKindOfClass:[NSNumber class]], @"Invalid dictionary format. A NSNumber is required!");
    
    return row[2];
}

- (NSArray *)getOptionValuesAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([info_.allValues[indexPath.section] isKindOfClass:[NSArray class]], @"Invalid dictionary format. A NSArray is"
        " required!");

    NSArray *row = [self getRowAtIndexPath:indexPath];
    NSNumber *type = row[2];
    NSArray *options = row[3];
    NSMutableArray *result = [NSMutableArray arrayWithArray:options];

    NSAssert([type isKindOfClass:[NSNumber class]], @"Invalid dictionary format. A NSNumber is required!");
    NSAssert([type intValue] == OPTION, @"Invalid selected field. It's must be a OPTION field!");
    NSAssert([options isKindOfClass:[NSArray class]], @"Invalid dictionary format. A NSArray is required!");
    
    [result insertObject:NSLocalizedString(@"Choose one", nil) atIndex:0];
    
    return result;
}

- (void)setInfo:(NSDictionary *)info
{
    info_ = info;
    _allFields = nil;
    _allValues = nil;
}

- (void)setValuesWithDictionary:(NSDictionary *)info section:(int)section
{
    NSArray *infoKeys = info.allKeys;
    NSArray *infoValues = info.allValues;
    
    for (int i = 0; i < [infoKeys count]; i++)
    {
        NSNumber *index =  [self getIndexWithKey:infoKeys[i] section:section];
        
        if (index)
        {
            self.allValues[section][[index intValue]] = infoValues[i];
        }
    }
}

#pragma mark - Private Methods
- (NSNumber *)getIndexWithKey:(NSString *)key section:(int)section
{
    NSNumber *result = nil;
    
    for (int i = 0; i < [self.allFields[section] count]; i++)
    {
        NSString *current = self.allFields[section][i];
        
        if ([[current lowercaseString] isEqualToString:[key lowercaseString]])
        {
            return [NSNumber numberWithInt:i];
        }
    }
    
    return result;
}

@end
