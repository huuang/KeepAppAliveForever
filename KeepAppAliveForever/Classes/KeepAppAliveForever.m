//
//  KeepAppAliveForever.m
//  KeepAppAliveForever
//
//  Created by Jihua Huang on 2021/9/7.
//  Copyright (c) 2021 Jihua Huang. All rights reserved.
//

#import "KeepAppAliveForever.h"
#import <AVFoundation/AVFoundation.h>

@interface KeepAppAliveForever()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, assign) BOOL enabled;

@end

@implementation KeepAppAliveForever

+ (instancetype)sharedInstance
{
    static KeepAppAliveForever *instance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [KeepAppAliveForever new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(beginBackgroundTask) name: UIApplicationDidEnterBackgroundNotification object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(endBackgroundTask) name: UIApplicationWillEnterForegroundNotification object: nil];
    }
    return self;
}

- (void)beginBackgroundTask
{
    if (!self.enabled) {
        return;
    }

    if (self.player == nil) {
        NSBundle *bundle = [NSBundle bundleWithURL: [[NSBundle mainBundle] URLForResource: @"KeepAppAliveForever" withExtension: @"bundle"]];
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback withOptions: AVAudioSessionCategoryOptionMixWithOthers error: NULL];
        self.player = [AVPlayer playerWithURL: [bundle URLForResource: @"keep_app_alive_forever" withExtension: @"wav"]];
        self.player.allowsExternalPlayback = NO;
        [self.player play];
    }

    assert(self.backgroundTaskIdentifier == UIBackgroundTaskInvalid);
    __weak typeof(self) weakSelf = self;
    self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler: ^{
        [[UIApplication sharedApplication] endBackgroundTask: weakSelf.backgroundTaskIdentifier];
        weakSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }];
}

- (void)endBackgroundTask
{
    if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask: self.backgroundTaskIdentifier];
        self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    }
}

- (void)enable
{
    _enabled = YES;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        [self beginBackgroundTask];
    }
}

- (void)disable
{
    _enabled = NO;
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        [self endBackgroundTask];
    }
}

@end
