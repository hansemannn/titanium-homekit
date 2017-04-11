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
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    __weak TiHomekitModule *weakSelf = self;

    [[self homeManager] addHomeWithName:name
                      completionHandler:^(HMHome *home, NSError *error) {
                          NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{@"success": NUMBOOL(error == nil)}];
                          
                          if (error != nil) {
                              [event setObject:[error localizedDescription] forKey:@"error"];
                          } else {
                              [event setObject:@{@"uniqueIdentifier": home.uniqueIdentifier.UUIDString} forKey:@"home"];
                          }
                          
                          NSArray *invocation = [NSArray arrayWithObjects:event, nil];
                          
                          [callback call:invocation thisObject:weakSelf];
                      }];
}

- (void)removeHome:(id)args
{
    NSString *uuid;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(uuid, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    HMHome *selectedHome = nil;
    
    for (HMHome *home in [[self homeManager] homes]) {
        if ([[[home uniqueIdentifier] UUIDString] isEqualToString:uuid]) {
            selectedHome = home;
        }
    }
    
    if (selectedHome == nil) {
        NSDictionary *event = @{@"success": NUMBOOL(NO), @"error": @"Home not found!"};
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        
        [callback call:invocation thisObject:self];
        return;
    }
    
    __weak TiHomekitModule *weakSelf = self;

    [[self homeManager] removeHome:selectedHome
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
    NSString *uuid;
    KrollCallback *callback;
    
    ENSURE_ARG_AT_INDEX(uuid, args, 0, NSString);
    ENSURE_ARG_AT_INDEX(callback, args, 0, KrollCallback);
    
    HMHome *selectedHome = nil;
    
    for (HMHome *home in [[self homeManager] homes]) {
        if ([[[home uniqueIdentifier] UUIDString] isEqualToString:uuid]) {
            selectedHome = home;
        }
    }
    
    if (selectedHome == nil) {
        NSDictionary *event = @{@"success": NUMBOOL(NO), @"error": @"Home not found!"};
        NSArray *invocation = [NSArray arrayWithObjects:event, nil];
        
        [callback call:invocation thisObject:self];
        return;
    }
    
    __weak TiHomekitModule *weakSelf = self;

    [[self homeManager] updatePrimaryHome:selectedHome
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

-(void)homeManager:(HMHomeManager *)manager didAddHome:(HMHome *)home
{
    if ([self _hasListeners:@"didAddHome"]) {
        [self fireEvent:@"didAddHome" withObject:@{@"home": @{@"uniqueIdentifier": home.uniqueIdentifier.UUIDString}}];
    }
}

-(void)homeManager:(HMHomeManager *)manager didRemoveHome:(HMHome *)home
{
    if ([self _hasListeners:@"didRemoveHome"]) {
        [self fireEvent:@"didRemoveHome" withObject:@{@"home": @{@"uniqueIdentifier": home.uniqueIdentifier.UUIDString}}];
    }
}

-(void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    if ([self _hasListeners:@"didUpdateHomes"]) {
        [self fireEvent:@"didUpdateHomes"];
    }
}

-(void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    if ([self _hasListeners:@"didUpdatePrimaryHome"]) {
        [self fireEvent:@"didUpdatePrimaryHome"];
    }
}

@end
