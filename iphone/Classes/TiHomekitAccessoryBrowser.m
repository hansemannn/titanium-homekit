/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitAccessoryBrowser.h"

@implementation TiHomekitAccessoryBrowser

- (HMAccessoryBrowser *)browser
{
    if (_browser == nil) {
        _browser = [[HMAccessoryBrowser alloc] init];
        _browser.delegate = self;
    }
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
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[[self browser] discoveredAccessories]];
    
    for (HMAccessory *accessory in [[self browser] discoveredAccessories]) {
        [result addObject:@{
            @"uniqueIdentifier": accessory.uniqueIdentifier.UUIDString,
            @"name": accessory.name,
            @"bridged": NUMBOOL(accessory.isBridged),
            @"reachable": NUMBOOL(accessory.isReachable),
            // TODO: Expose all properties
        }];
    }
    
    return result;
}

#pragma mark Delegates

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didFindNewAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didFindNewAccessory"]) {
        [self fireEvent:@"didFindNewAccessory" withObject:@{@"accessory": @{@"name": accessory.name, @"uniqueIdentifier": accessory.uniqueIdentifier.UUIDString}}];
    }
}

- (void)accessoryBrowser:(HMAccessoryBrowser *)browser didRemoveNewAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didRemoveNewAccessory"]) {
        [self fireEvent:@"didRemoveNewAccessory" withObject:@{@"accessory": @{@"name": accessory.name, @"uniqueIdentifier": accessory.uniqueIdentifier.UUIDString}}];
    }
}

@end
