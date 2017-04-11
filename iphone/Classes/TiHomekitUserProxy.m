/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitUserProxy.h"

@implementation TiHomekitUserProxy

- (id)_initWithPageContext:(id<TiEvaluator>)context andUser:(HMUser *)user;
{
    if (self = [super _initWithPageContext:context]) {
        self.user = user;
    }
    
    return self;
}

#pragma mark Public APIs

- (id)name
{
    return _user.name;
}

- (id)uniqueIdentifier
{
    return _user.uniqueIdentifier;
}

@end
