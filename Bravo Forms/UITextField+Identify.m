//
//  UITextField+Identification.m
//  Bravo Forms
//
//  Created by Paulo Pinheiro on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "UITextField+Identify.h"
#import <objc/runtime.h>


@implementation UITextField (Identify)

static char ContextPrivateKey;

- (void)setType:(NSNumber *)type
{
    objc_setAssociatedObject(self, &ContextPrivateKey, type, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)type
{
    return objc_getAssociatedObject(self, &ContextPrivateKey);
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, &ContextPrivateKey, indexPath, OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, &ContextPrivateKey);
}

@end
