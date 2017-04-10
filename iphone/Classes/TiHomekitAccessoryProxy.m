/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitAccessoryProxy.h"
#import "TiHomekitServiceProxy.h"
#import "TiHomekitRoomProxy.h"

@implementation TiHomekitAccessoryProxy

- (id)_initWithPageContext:(id<TiEvaluator>)context andAccessory:(HMAccessory *)accessory
{
    if (self = [super _initWithPageContext:context]) {
        self.accessory = accessory;
        self.accessory.delegate = self;
    }
    
    return self;
}

#pragma mark Public APIs

- (id)uniqueIdentifier
{
    return [[_accessory uniqueIdentifier] UUIDString];
}

- (id)name
{
    return [_accessory name];
}

- (id)isReachable
{
    return NUMBOOL([_accessory isReachable]);
}

- (id)isBridged
{
    return NUMBOOL([_accessory isBridged]);
}

- (id)isBlocked
{
    return NUMBOOL([_accessory isBlocked]);
}

- (id)room
{
    return [[TiHomekitRoomProxy alloc] _initWithPageContext:[self pageContext] andRoom:[_accessory room]];
}

- (id)services
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[[_accessory services] count]];
    
    for (HMService *service in [_accessory services]) {
        [result addObject:[[TiHomekitServiceProxy alloc] _initWithPageContext:[self pageContext] andService:service]];
    }
    
    return result;
}

#pragma mark Delegates

- (void)accessoryDidUpdateName:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didUpdateName"]) {
        [self fireEvent:@"didUpdateName" withObject:@{
            @"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]
        }];
    }
}

- (void)accessory:(HMAccessory *)accessory didUpdateNameForService:(HMService *)service
{
    if ([self _hasListeners:@"didUpdateNameForService"]) {
        [self fireEvent:@"didUpdateNameForService" withObject:@{
            @"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory],
            @"service": [[TiHomekitServiceProxy alloc] _initWithPageContext:[self pageContext] andService:service]
        }];
    }
}

- (void)accessory:(HMAccessory *)accessory didUpdateAssociatedServiceTypeForService:(HMService *)service
{
    if ([self _hasListeners:@"didUpdateAssociatedServiceTypeForService"]) {
        [self fireEvent:@"didUpdateAssociatedServiceTypeForService" withObject:@{
            @"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory],
            @"service": [[TiHomekitServiceProxy alloc] _initWithPageContext:[self pageContext] andService:service]
        }];
    }
}

- (void)accessoryDidUpdateServices:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didUpdateServices"]) {
        [self fireEvent:@"didUpdateServices" withObject:@{
            @"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]
        }];
    }
}

- (void)accessoryDidUpdateReachability:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didUpdateReachability"]) {
        [self fireEvent:@"didUpdateReachability" withObject:@{
            @"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]
        }];
    }
}

- (void)accessory:(HMAccessory *)accessory service:(HMService *)service didUpdateValueForCharacteristic:(HMCharacteristic *)characteristic
{
    if ([self _hasListeners:@"didUpdateValueForCharacteristic"]) {
        [self fireEvent:@"didUpdateValueForCharacteristic" withObject:@{
            @"accessory": [[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory],
            @"service": [[TiHomekitServiceProxy alloc] _initWithPageContext:[self pageContext] andService:service],
            @"characteristic": @{
                @"characteristicType": [characteristic characteristicType],
                @"properties": [characteristic properties],
                @"value": [characteristic value]
            }
        }];
    }
    
}

@end
