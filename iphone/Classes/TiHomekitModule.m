/**
 * titanium-homekit
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Your Company. All rights reserved.
 */

#import "TiHomekitModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiHomekitHomeProxy.h"

@implementation TiHomekitModule

@synthesize homeManager = _homeManager;
    
#pragma mark Internal

- (id)moduleGUID
{
	return @"25660038-54d6-4f82-8dde-669e6da337cf";
}

- (NSString *)moduleId
{
	return @"ti.homekit";
}

- (HMHomeManager *)homeManager
{
    if (_homeManager == nil) {
        _homeManager = [[HMHomeManager alloc] init];
        _homeManager.delegate = self;
    }
    
    return _homeManager;
}

#pragma mark Lifecycle

- (void)startup
{
	[super startup];
	NSLog(@"[DEBUG] %@ loaded",self);
}

#pragma Public APIs

- (void)addHome:(id)args
{
    NSString *name;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(name, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 1, KrollCallback);
    
    __weak TiHomekitModule *weakSelf = self;

    [[self homeManager] addHomeWithName:name
                      completionHandler:^(HMHome *home, NSError *error) {
                          NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
                          
                          if (error != nil) {
                              [event setObject:[error localizedDescription] forKey:@"error"];
                          } else {
                              [event setObject:[[TiHomekitHomeProxy alloc] _initWithPageContext:[self pageContext] andHome:home] forKey:@"home"];
                          }
                          
                          NSArray *invocation = [NSArray arrayWithObjects:event, nil];
                          
                          [callback call:invocation thisObject:weakSelf];
                      }];
}

- (void)removeHome:(id)args
{
    TiHomekitHomeProxy *home;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(home, args, 0, TiHomekitHomeProxy);
    ENSURE_ARG_AT_INDEX(callback, args, 1, KrollCallback);
    
    __weak TiHomekitModule *weakSelf = self;

    [[self homeManager] removeHome:[home home]
                 completionHandler:^(NSError *error) {
                     NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
        
                     if (error != nil) {
                         [event setObject:[error localizedDescription] forKey:@"error"];
                     }
        
                     NSArray *invocation = [NSArray arrayWithObjects:event, nil];
                     [callback call:invocation thisObject:weakSelf];
    }];
}

- (void)updatePrimaryHome:(id)args
{
    TiHomekitHomeProxy *home;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(home, args, 0, TiHomekitHomeProxy);
    ENSURE_ARG_AT_INDEX(callback, args, 1, KrollCallback);
    
    __weak TiHomekitModule *weakSelf = self;

    [[self homeManager] updatePrimaryHome:[home home]
                        completionHandler:^(NSError *error) {
                            NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
                            
                            if (error != nil) {
                                [event setObject:[error localizedDescription] forKey:@"error"];
                            }
                            
                            NSArray *invocation = [NSArray arrayWithObjects:event, nil];
                            [callback call:invocation thisObject:weakSelf];
                        }];
}

#pragma mark Delegates

- (void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home
{
    if ([self _hasListeners:@"didAddHome"]) {
        [self fireEvent:@"didAddHome" withObject:@{
            @"home": [[TiHomekitHomeProxy alloc] _initWithPageContext:[self pageContext] andHome:home]
        }];
    }
}

- (void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home
{
    if ([self _hasListeners:@"didRemoveHome"]) {
        [self fireEvent:@"didRemoveHome" withObject:@{
            @"home": [[TiHomekitHomeProxy alloc] _initWithPageContext:[self pageContext] andHome:home]
        }];
    }
}

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    if ([self _hasListeners:@"didUpdateHomes"]) {
        [self fireEvent:@"didUpdateHomes"];
    }
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    if ([self _hasListeners:@"didUpdatePrimaryHome"]) {
        [self fireEvent:@"didUpdatePrimaryHome"];
    }
}

@end
