/**
 * titanium-homekit
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import <HomeKit/HomeKit.h>

@interface TiHomekitModule : TiModule <HMHomeManagerDelegate>

@property(nonatomic, strong) HMHomeManager *homeManager;

- (void)addHome:(id)args;

- (void)removeHome:(id)args;

- (void)updatePrimaryHome:(id)args;

@end
