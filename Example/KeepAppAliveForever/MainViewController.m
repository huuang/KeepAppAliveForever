//
//  MainViewController.m
//  KeepAppAliveForever
//
//  Created by huangjihua on 09/07/2021.
//  Copyright (c) 2021 huangjihua. All rights reserved.
//

#import "MainViewController.h"
#import <KeepAppAliveForever/KeepAppAliveForever.h>

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[KeepAppAliveForever sharedInstance] enable];
}

- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selected == 0) {
        [[KeepAppAliveForever sharedInstance] enable];
    } else {
        [[KeepAppAliveForever sharedInstance] disable];
    }
}

@end
