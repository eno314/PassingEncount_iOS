//
//  EnoIBeaconReceiver.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/10.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoIBeaconReceiver.h"

@interface EnoIBeaconReceiver()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSUUID            *proximityUUID;
@property (nonatomic, strong) CLBeaconRegion    *beaconRegion;

@end

/**
 * シングルトンクラスにして、アプリ内でiBeacon受信処理は共有できるようにする
 */
@implementation EnoIBeaconReceiver

static EnoIBeaconReceiver *sharedData_ = nil;

/**
 * シングルトンインスタンス取得用のメソッド
 */
+ (EnoIBeaconReceiver *)sharedManager
{
    @synchronized( self ) {
        
        if ( ! sharedData_ ) {
            
            sharedData_ = [[EnoIBeaconReceiver alloc] init];
        }
    }
    
    return sharedData_;
}

/**
 * 初期化処理
 */
- (id)init
{
    self = [super init];
    
    if ( self ) {
        
    }
    
    return self;
}

- (void)start
{
    if ( [CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]] ) {
        // CLLocationManagerの生成とデリゲート設定
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        // proximityUUIDの生成
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:[EnoConst serviceUUID]];
        
        // CLBeaconRegionの生成
        self.beaconRegion = [[CLBeaconRegion alloc]
                             initWithProximityUUID:self.proximityUUID
                             identifier:[EnoConst serviceIdentifer]];
        
        // beaconによる領域観測を開始
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
    }
}

# pragma mark - CLLocationManagerDelegate

/**
 * モニタリング開始が正常に始まった時に呼ばれる
 */
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    // 自分がibeacon監視でどういう状態にいるか知らせる
    [self.locationManager requestStateForRegion:self.beaconRegion];
}

/**
 * requestStateForRegionのコールバック
 */
- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    // リージョン内にいればBeaconの距離測定を開始
    if ( state == CLRegionStateInside ) {
        
        NSLog( @"CLRegionStateInside" );
        
        if ( [region isMemberOfClass:[CLBeaconRegion class]]&&[CLLocationManager isRangingAvailable] ) {
            
            [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
        }
        
        return;
    }
}

/**
 * Beaconに近づいた時に呼ばれるイベント
 */
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog( @"Enter Region" );
    
    // Beaconの距離測定を開始する
    if ( [region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable] ) {
        
        [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

/**
 * Beaconから遠ざかった
 */
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    NSLog( @"Exit Region" );
    
    // Beaconの距離測定を終了する
    if ( [region isMemberOfClass:[CLBeaconRegion class]] && [CLLocationManager isRangingAvailable] ) {
        
        [self.locationManager stopRangingBeaconsInRegion:(CLBeaconRegion *)region];
    }
}

/**
 * 距離測定イベントをハンドリングする
 */
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    for ( int i = 0; i < beacons.count; i++ ) {
        
        CLBeacon *beacon = [beacons objectAtIndex:i];
        
        NSString *rangeMessage;
        
        switch ( beacon.proximity ) {
            case CLProximityImmediate:
                rangeMessage = @"CLProximityImmediate: ";
                break;
                
            case CLProximityNear:
                rangeMessage = @"CLProximityNear : ";
                break;
                
            case CLProximityFar:
                rangeMessage = @"CLProximityFar : ";
                break;
                
            default:
                rangeMessage = @"CLProximityUnkonwn : ";
                break;
        }
        
        NSString *message = [NSString stringWithFormat:@"major:%@, minor:%@, accuracy:%f, rssi:%ld",
                             beacon.major, beacon.minor, beacon.accuracy, (long)beacon.rssi];
        NSLog( @"%@", [rangeMessage stringByAppendingString:message] );
    }
    
    if ( beacons.count > 0 ) {
        // とりあえず必ずバイブする
        AudioServicesPlaySystemSound( kSystemSoundID_Vibrate );
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:beacons.count];
    }
}

@end
