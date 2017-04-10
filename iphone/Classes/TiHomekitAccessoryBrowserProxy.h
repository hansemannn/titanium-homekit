/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2017 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"

#import <HomeKit/HomeKit.h>

@interface TiHomekitAccessoryBrowserProxy : TiProxy<HMAccessoryBrowserDelegate>

@property(nonatomic, strong) HMAccessoryBrowser *browser;

@end
