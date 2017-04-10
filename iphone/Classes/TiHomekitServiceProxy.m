/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitServiceProxy.h"

@implementation TiHomekitServiceProxy

- (id)_initWithPageContext:(id<TiEvaluator>)context andService:(HMService *)service
{
    if (self = [super _initWithPageContext:context]) {
        self.service = service;
    }
    
    return self;
}

#pragma mark Public APIs

- (id)name
{
    return [_service name];
}

- (id)localizedDescription
{
    return [_service localizedDescription];
}

- (id)serviceType
{
    return [_service serviceType];
}

- (id)uniqueIdentifier
{
    return [[_service uniqueIdentifier] UUIDString];
}

@end
