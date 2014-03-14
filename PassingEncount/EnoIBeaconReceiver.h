//
//  EnoIBeaconReceiver.h
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/10.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioServices.h>

#import "EnoConst.h"

@interface EnoIBeaconReceiver : NSObject <CLLocationManagerDelegate>

+ (EnoIBeaconReceiver *)sharedManager;
- (void)start;

@end
