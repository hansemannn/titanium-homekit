/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"

#import <HomeKit/HomeKit.h>

@interface TiHomekitAccessoryProxy : TiProxy<HMAccessoryDelegate> {

}

@property(nonatomic, strong) HMAccessory *accessory;

- (id)_initWithPageContext:(id<TiEvaluator>)context andAccessory:(HMAccessory *)accessory;

- (id)uniqueIdentifier;

- (id)name;

- (id)isReachable;

- (id)isBridged;

- (id)isBlocked;

- (id)room;

- (id)services;

@end
