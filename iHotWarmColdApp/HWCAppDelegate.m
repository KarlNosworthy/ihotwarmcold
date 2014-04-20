//
//  HWCAppDelegate.m
//  iHotWarmCold
//
//  Created by Karl Nosworthy on 18/04/2014.
//  Copyright (c) 2014 Karl Nosworthy. All rights reserved.
//

#import "HWCAppDelegate.h"
#import "HWCViewController.h"

@implementation HWCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[HWCViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
