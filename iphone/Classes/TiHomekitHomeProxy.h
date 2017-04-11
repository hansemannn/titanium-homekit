/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"

#import <HomeKit/HomeKit.h>

@class TiHomekitUserProxy;

@interface TiHomekitHomeProxy : TiProxy<HMHomeDelegate>

@property(nonatomic, strong) HMHome *home;

- (id)_initWithPageContext:(id<TiEvaluator>)context andHome:(HMHome *)home;

- (id)uniqueIdentifier;

- (id)name;

- (void)updateName:(id)args;

- (void)addAccessory:(id)args;

- (void)removeAccessory:(id)args;

- (void)assignAccessory:(id)args;

- (void)addAndSetupAccessories:(id)value;

- (void)manageUsers:(id)value;

- (void)addUser:(id)value;

- (void)removeUser:(id)value;

- (TiHomekitUserProxy *)currentUser;

- (id)homeAccessControlForUser:(id)args;

- (void)addRoom:(id)value;

- (void)removeRoom:(id)value;

@end
