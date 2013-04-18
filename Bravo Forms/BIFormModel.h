//
//  BIFormModel.h
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    STRING,
    PASSWORD,
    EMAIL,
    NUMBER,
    DATE,
    OPTION,
    BUTTON
} BIFormType;

@interface BIFormModel : NSObject
{
@private
    __strong NSDictionary *info_;
}

#pragma mark - Public Methods
- (id)initWithInfo:(NSDictionary *)info;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSArray *)getRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSNumber *)getTypeAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)getOptionValuesAtIndexPath:(NSIndexPath *)indexPath;
- (void)setInfo:(NSDictionary *)info;

#pragma mark - Lazy Properties
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *allFields;
@property (nonatomic, strong) NSArray *allValues;

@end
