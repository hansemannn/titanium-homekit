/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitRoomProxy.h"
#import "TiHomekitAccessoryProxy.h"

@implementation TiHomekitRoomProxy

- (id)_initWithPageContext:(id<TiEvaluator>)context andRoom:(HMRoom *)room
{
    if (self = [super _initWithPageContext:context]) {
        self.room = room;
    }
    
    return self;
}

#pragma mark Public APIs

- (id)name
{
    return [_room name];
}

- (id)uniqueIdentifier
{
    return [[_room uniqueIdentifier] UUIDString];
}

- (NSArray *)accessories
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[[_room accessories] count]];
    
    for (HMAccessory *accessory in [_room accessories]) {
        [result addObject:[[TiHomekitAccessoryProxy alloc] _initWithPageContext:[self pageContext] andAccessory:accessory]];
    }
    
    return result;
}

- (void)updateName:(id)args
{
    NSString *name;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitRoomProxy *weakSelf = self;

    [_room updateName:name completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

@end
