//
//  UITextField+Identification.m
//  Bravo Forms
//
//  Created by Sérgio Vieirao on 4/11/13.
//  Copyright (c) 2013 Bravo Inovação. All rights reserved.
//

#import "UITextField+Identify.h"
#import <objc/runtime.h>


@implementation UITextField (Identify)

static char ContextPrivateKeyIndexPath;
static char ContextPrivateKeyType;

- (void)setType:(NSNumber *)type
{
    objc_setAssociatedObject(self, &ContextPrivateKeyType, type, OBJC_ASSOCIATION_RETAIN);
}

- (NSNumber *)type
{
    return objc_getAssociatedObject(self, &ContextPrivateKeyType);
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, &ContextPrivateKeyIndexPath, indexPath, OBJC_ASSOCIATION_RETAIN);
}

- (NSIndexPath *)indexPath
{
    return objc_getAssociatedObject(self, &ContextPrivateKeyIndexPath);
}

@end
