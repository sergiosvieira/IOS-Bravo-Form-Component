//
//  BIFormViewCell.m
//  Bravo Forms
//
//  Created by Sérgio Vieira on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "BIFormViewCell.h"

#define kFONT_SIZE 13.f

const CGRect CGRectLabel = {
    {
        20.0f,
        0.0f
    },
    {
        80.0f,
        43.0f
    }
};

@implementation BIFormViewCell

- (UILabel *)lbCaption
{
    if (!_lbCaption)
    {
        CGRect frame = CGRectLabel;
        
        _lbCaption = [[UILabel alloc] initWithFrame:frame];
        
        /** customize **/
        _lbCaption.backgroundColor = [UIColor clearColor];
        _lbCaption.font = [UIFont boldSystemFontOfSize:kFONT_SIZE];
        _lbCaption.opaque = YES;
    }
    
    return _lbCaption;
}

- (UIImageView *)imageField
{
    if (!_imageField)
    {
        _imageField = [[UIImageView alloc] initWithFrame:CGRectMake(128.f, 5.f, 30.f, 30.f)];
        [self addSubview:_imageField];
    }
    
    return _imageField;
}

- (UITextField *)tfField
{
    if (!_tfField)
    {
        CGRect frame = CGRectMake
        (
            123.f,//self.bbiActions.width,
            7.f,
            150.f,
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

#pragma mark - Public Methods
- (void)defaultLabelPosition
{
    self.lbCaption.textAlignment = UITextAlignmentLeft;
    self.lbCaption.frame = CGRectLabel;
}

- (void)centerLabelPosition
{
    CGRect frame = self.lbCaption.superview.frame;
    
    self.lbCaption.textAlignment = UITextAlignmentCenter;
    self.lbCaption.frame = frame;
}

- (void)buttonLabelPosition
{
    CGRect frame = self.lbCaption.frame;
    
    frame.size.width += 100.f;
    self.lbCaption.frame = frame;
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
