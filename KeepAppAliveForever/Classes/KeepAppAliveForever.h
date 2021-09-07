//
//  KeepAppAliveForever.h
//  KeepAppAliveForever
//
//  Created by Jihua Huang on 2021/9/7.
//  Copyright (c) 2021 Jihua Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeepAppAliveForever : NSObject

+ (instancetype)sharedInstance;

- (void)enable;
- (void)disable;

@end

NS_ASSUME_NONNULL_END
