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
    BUTTON,
    CUSTOM,
    STRING_WITH_BUTTON,
    IMAGE
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
- (NSString *)getImageNameAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)getOptionValuesAtIndexPath:(NSIndexPath *)indexPath;
- (void)setInfo:(NSDictionary *)info;
- (NSDictionary *)getInfo;
- (void)setValuesWithDictionary:(NSDictionary *)info section:(int)section;
- (void)setValueWithIndexPath:(NSIndexPath *)indexPath value:(NSString *)value;
- (void)setValueByKey:(NSString *)key value:(NSString *)value;
- (void)clearAllValues;

#pragma mark - Lazy Properties
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *allFields;
@property (nonatomic, strong) NSArray *allValues;

@property (nonatomic, strong, readonly) NSDictionary *info;

@end
