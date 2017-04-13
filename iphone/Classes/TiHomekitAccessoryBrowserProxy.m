/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitAccessoryBrowserProxy.h"
#import "TiHomekitAccessoryProxy.h"

@implementation TiHomekitAccessoryBrowserProxy

- (HMAccessoryBrowser *)browser
{
    if (_browser == nil) {
        _browser = [[HMAccessoryBrowser alloc] init];
        _browser.delegate = self;
    }
    
    return _browser;
}

#pragma mark Public API's

- (void)startSearchingForNewAccessories:(id)unused
{
    [[self browser] startSearchingForNewAccessories];
}

- (void)stopSearchingForNewAccessories:(id)unused
{
    [[self browser] stopSearchingForNewAccessories];
}

- (NSArray *)discoveredAccessories
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[[[self browser] discoveredAccessories] count]];
    
    for (HMAccessory *accessory in [[self browser] discoveredAccessories]) {
        [result addObject:[[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]];
    }
    
    return result;
}

#pragma mark Delegates

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didFindNewAccessory"]) {
        [self fireEvent:@"didFindNewAccessory" withObject:@{@"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]}];
    }
}

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didRemoveNewAccessory"]) {
        [self fireEvent:@"didRemoveNewAccessory" withObject:@{@"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]}];
    }
}

@end
