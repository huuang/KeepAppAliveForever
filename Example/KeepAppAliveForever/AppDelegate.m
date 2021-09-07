//
//  AppDelegate.m
//  KeepAppAliveForever
//
//  Created by huangjihua on 09/07/2021.
//  Copyright (c) 2021 huangjihua. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            __block BOOL backgroundState = YES;
            dispatch_sync(dispatch_get_main_queue(), ^{
                backgroundState = [UIApplication sharedApplication].applicationState == UIApplicationStateBackground;
            });
            if (backgroundState) {
                __block long backgroundTimeRemaining = 0;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    backgroundTimeRemaining = [UIApplication sharedApplication].backgroundTimeRemaining;
                });
                NSLog(@"Background time remaining: %ld", backgroundTimeRemaining);
            } else {
                NSLog(@"The App is not in background state.");
            }
            sleep(1);
        }
    });
    return YES;
}

@end
