/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiHomekitHomeProxy.h"
#import "TiHomekitAccessoryProxy.h"
#import "TiHomekitRoomProxy.h"
#import "TiHomekitUserProxy.h"

@implementation TiHomekitHomeProxy

- (id)_initWithPageContext:(id<TiEvaluator>)context andHome:(HMHome *)home
{
    if (self = [super _initWithPageContext:context]) {
        self.home = home;
        self.home.delegate = self;
    }
    
    return self;
}

#pragma mark - Public API's

#pragma mark Properties

- (id)uniqueIdentifier
{
    return [[_home uniqueIdentifier] UUIDString];
}

- (id)name
{
    return [_home name];
}

- (id)isPrimary
{
    return NUMBOOL([_home isPrimary]);
}

#pragma mark Methods

- (void)updateName:(id)args
{
    NSString *name;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;

    [_home updateName:name completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

#pragma mark Handle Accessories

- (void)addAccessory:(id)args
{
    TiHomekitAccessoryProxy *accessory;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(accessory, args, 0, TiHomekitAccessoryProxy);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home addAccessory:[accessory accessory] completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

- (void)removeAccessory:(id)args
{
    TiHomekitAccessoryProxy *accessory;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(accessory, args, 0, TiHomekitAccessoryProxy);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home removeAccessory:[accessory accessory] completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

- (void)assignAccessory:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    TiHomekitAccessoryProxy *accessory;
    TiHomekitRoomProxy *room;
    KrollCallback *callback;
    
    ENSURE_ARG_FOR_KEY(accessory, args, @"accessory", TiHomekitAccessoryProxy);
    ENSURE_ARG_FOR_KEY(room, args, @"room", TiHomekitHomeProxy);
    ENSURE_ARG_FOR_KEY(callback, args, @"callback", KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home assignAccessory:[accessory accessory]
                    toRoom:[room room]
         completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
            if (error != nil) {
                [event setObject:[error localizedDescription] forKey:@"error"];
            }
        
             NSArray *invocation = [NSArray arrayWithObjects:event, nil];
             [callback call:invocation thisObject:weakSelf];
    }];
}

- (void)addAndSetupAccessories:(id)value
{
    ENSURE_SINGLE_ARG(value, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;

    [_home addAndSetupAccessoriesWithCompletionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [value call:invocation thisObject:weakSelf];
    }];
}

#pragma mark Handle Users

- (void)manageUsers:(id)value
{
    ENSURE_SINGLE_ARG(value, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home manageUsersWithCompletionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [value call:invocation thisObject:weakSelf];
    }];
}

- (void)addUser:(id)value
{
    ENSURE_SINGLE_ARG(value, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home addUserWithCompletionHandler:^(HMUser *user, NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        } else {
            [event setObject:[[TiHomekitUserProxy alloc] _initWithPageContext:[weakSelf pageContext] andUser:user] forKey:@"user"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [value call:invocation thisObject:weakSelf];
    }];
}

- (void)removeUser:(id)args
{
    TiHomekitUserProxy *user;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(user, args, 0, TiHomekitUserProxy);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home removeUser:[user user] completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

- (TiHomekitUserProxy *)currentUser
{
    return [[TiHomekitUserProxy alloc] _initWithPageContext:[self pageContext] andUser:[_home currentUser]];
}

- (id)homeAccessControlForUser:(id)args
{
    TiHomekitUserProxy *user;
    ENSURE_ARG_AT_INDEX(user, args, 0, TiHomekitUserProxy);
    
    return @{@"isAdministrator": NUMBOOL([[_home homeAccessControlForUser:[user user]] isAdministrator])};
}

#pragma mark Handle Rooms

- (void)addRoom:(id)args
{
    NSString *name;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home addRoomWithName:name completionHandler:^(HMRoom *room, NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        } else {
            [event setObject:[[TiHomekitRoomProxy alloc] _initWithPageContext:[weakSelf pageContext] andRoom:room] forKey:@"room"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

- (void)removeRoom:(id)args
{
    TiHomekitRoomProxy *room;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(room, args, 0, TiHomekitRoomProxy);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitHomeProxy *weakSelf = self;
    
    [_home removeRoom:[room room] completionHandler:^(NSError *error) {
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        if (error != nil) {
            [event setObject:[error localizedDescription] forKey:@"error"];
        }
        
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        [callback call:invocation thisObject:weakSelf];
    }];
}

#pragma mark - Delegates

- (void)homeDidUpdateName:(HMHome *)home
{
    if ([self _hasListeners:@"didFindNewAccessory"]) {
        [self fireEvent:@"homeDidUpdateName"];
    }
}

- (void)home:(HMHome *)home didAddAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didAddAccessory"]) {
        [self fireEvent:@"didAddAccessory"];
    }
}

- (void)home:(HMHome *)home didRemoveAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didRemoveAccessory"]) {
        [self fireEvent:@"didRemoveAccessory"];
    }
}

- (void)home:(HMHome *)home didAddUser:(HMUser *)user
{
    if ([self _hasListeners:@"didAddUser"]) {
        [self fireEvent:@"didAddUser"];
    }
}

- (void)home:(HMHome *)home didRemoveUser:(HMUser *)user
{
    if ([self _hasListeners:@"didRemoveUser"]) {
        [self fireEvent:@"didRemoveUser"];
    }
}

- (void)home:(HMHome *)home didUpdateRoom:(HMRoom *)room forAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didUpdateRoom"]) {
        [self fireEvent:@"didUpdateRoom"];
    }
}

- (void)home:(HMHome *)home didAddRoom:(HMRoom *)room
{
    if ([self _hasListeners:@"didAddRoom"]) {
        [self fireEvent:@"didAddRoom"];
    }
}

- (void)home:(HMHome *)home didRemoveRoom:(HMRoom *)room
{
    if ([self _hasListeners:@"didRemoveRoom"]) {
        [self fireEvent:@"didRemoveRoom"];
    }
}

- (void)home:(HMHome *)home didUpdateNameForRoom:(HMRoom *)room
{
    if ([self _hasListeners:@"didUpdateNameForRoom"]) {
        [self fireEvent:@"didUpdateNameForRoom"];
    }
}

- (void)home:(HMHome *)home didAddZone:(HMZone *)zone
{
    if ([self _hasListeners:@"didAddZone"]) {
        [self fireEvent:@"didAddZone"];
    }
}

- (void)home:(HMHome *)home didRemoveZone:(HMZone *)zone
{
    if ([self _hasListeners:@"didRemoveZone"]) {
        [self fireEvent:@"didRemoveZone"];
    }
}

- (void)home:(HMHome *)home didUpdateNameForZone:(HMZone *)zone
{
    if ([self _hasListeners:@"didUpdateNameForZone"]) {
        [self fireEvent:@"didUpdateNameForZone"];
    }
}

- (void)home:(HMHome *)home didAddRoom:(HMRoom *)room toZone:(HMZone *)zone
{
    if ([self _hasListeners:@"didAddRoom"]) {
        [self fireEvent:@"didAddRoom"];
    }
}

- (void)home:(HMHome *)home didRemoveRoom:(HMRoom *)room fromZone:(HMZone *)zone
{
    if ([self _hasListeners:@"didRemoveRoom"]) {
        [self fireEvent:@"didRemoveRoom"];
    }
}

- (void)home:(HMHome *)home didAddServiceGroup:(HMServiceGroup *)group
{
    if ([self _hasListeners:@"didAddServiceGroup"]) {
        [self fireEvent:@"didAddServiceGroup"];
    }
}

- (void)home:(HMHome *)home didRemoveServiceGroup:(HMServiceGroup *)group
{
    if ([self _hasListeners:@"didRemoveServiceGroup"]) {
        [self fireEvent:@"didRemoveServiceGroup"];
    }
}

- (void)home:(HMHome *)home didUpdateNameForServiceGroup:(HMServiceGroup *)group
{
    if ([self _hasListeners:@"didUpdateNameForServiceGroup"]) {
        [self fireEvent:@"didUpdateNameForServiceGroup"];
    }
}

- (void)home:(HMHome *)home didAddService:(HMService *)service toServiceGroup:(HMServiceGroup *)group
{
    if ([self _hasListeners:@"didAddService"]) {
        [self fireEvent:@"didAddService"];
    }
}

- (void)home:(HMHome *)home didRemoveService:(HMService *)service fromServiceGroup:(HMServiceGroup *)group
{
    if ([self _hasListeners:@"didRemoveService"]) {
        [self fireEvent:@"didRemoveService"];
    }
}

- (void)home:(HMHome *)home didAddActionSet:(HMActionSet *)actionSet
{
    if ([self _hasListeners:@"didAddActionSet"]) {
        [self fireEvent:@"didAddActionSet"];
    }
}

- (void)home:(HMHome *)home didRemoveActionSet:(HMActionSet *)actionSet
{
    if ([self _hasListeners:@"didRemoveActionSet"]) {
        [self fireEvent:@"didRemoveActionSet"];
    }
}

- (void)home:(HMHome *)home didUpdateNameForActionSet:(HMActionSet *)actionSet
{
    if ([self _hasListeners:@"didUpdateNameForActionSet"]) {
        [self fireEvent:@"didUpdateNameForActionSet"];
    }
}

- (void)home:(HMHome *)home didUpdateActionsForActionSet:(HMActionSet *)actionSet
{
    if ([self _hasListeners:@"didFindNewAccessory"]) {
        [self fireEvent:@"homeDidUpdateName"];
    }
}

- (void)home:(HMHome *)home didAddTrigger:(HMTrigger *)trigger
{
    if ([self _hasListeners:@"didAddTrigger"]) {
        [self fireEvent:@"didAddTrigger"];
    }
}

- (void)home:(HMHome *)home didRemoveTrigger:(HMTrigger *)trigger
{
    if ([self _hasListeners:@"didRemoveTrigger"]) {
        [self fireEvent:@"didRemoveTrigger"];
    }
}

- (void)home:(HMHome *)home didUpdateNameForTrigger:(HMTrigger *)trigger
{
    if ([self _hasListeners:@"didUpdateNameForTrigger"]) {
        [self fireEvent:@"didUpdateNameForTrigger"];
    }
}

- (void)home:(HMHome *)home didUpdateTrigger:(HMTrigger *)trigger
{
    if ([self _hasListeners:@"didFindNewAccessory"]) {
        [self fireEvent:@"homeDidUpdateName"];
    }
}

- (void)home:(HMHome *)home didUnblockAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didUpdateNameForTrigger"]) {
        [self fireEvent:@"didUpdateNameForTrigger"];
    }
}

- (void)home:(HMHome *)home didEncounterError:(NSError*)error forAccessory:(HMAccessory *)accessory
{
    if ([self _hasListeners:@"didEncounterError"]) {
        [self fireEvent:@"didEncounterError"];
    }
}

@end
