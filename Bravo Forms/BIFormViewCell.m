//
//  BIFormViewCell.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormViewCell.h"

#define kFONT_SIZE 13.f

@implementation BIFormViewCell

- (UILabel *)lbCaption
{
    if (!_lbCaption)
    {
        CGRect frame = CGRectMake
        (
            20.f,//self.bbiActions.width,
            0.f,
            80.f,
            43.f
        );
        
        _lbCaption = [[UILabel alloc] initWithFrame:frame];
        
        /** customize **/
        _lbCaption.backgroundColor = [UIColor clearColor];
        _lbCaption.font = [UIFont boldSystemFontOfSize:kFONT_SIZE];
        _lbCaption.opaque = YES;
    }
    
    return _lbCaption;
}

- (UITextField *)tfField
{
    if (!_tfField)
    {
        CGRect frame = CGRectMake
        (
            123.f,//self.bbiActions.width,
            7.f,
            190.f,
            30.f
        );
        
        _tfField = [[UITextField alloc] initWithFrame:frame];
        
        /** customize **/
        _tfField.borderStyle = UITextBorderStyleNone;
        _tfField.font = [UIFont systemFontOfSize:kFONT_SIZE];
//        _tffield.placeholder = NSLocalizedString(@"Type a message", nil);
        _tfField.autocorrectionType = UITextAutocorrectionTypeNo;
        _tfField.keyboardType = UIKeyboardTypeDefault;
        _tfField.returnKeyType = UIReturnKeyDone;
        _tfField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tfField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _tfField.opaque = YES;
    }
    
    return _tfField;
}

#pragma mark - Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self initialize];
    }
    return self;
}

#pragma mark - Private Methods
- (void)initialize
{
    /** UILabel **/
    [self addSubview:self.lbCaption];
    
    /** UITextField **/
    [self addSubview:self.tfField];
}

@end
