/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"

#import <HomeKit/HomeKit.h>

@interface TiHomekitRoomProxy : TiProxy {

}

@property(nonatomic, strong) HMRoom *room;

- (id)_initWithPageContext:(id<TiEvaluator>)context andRoom:(HMRoom *)room;

- (id)name;

- (id)uniqueIdentifier;

- (NSArray *)accessories;

@end
