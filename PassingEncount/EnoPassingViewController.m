//
//  EnoPassingViewController.m
//  PassingEncount
//
//  Created by hiroto kitamur on 2014/03/01.
//  Copyright (c) 2014年 Hiroto Kitamur. All rights reserved.
//

#import "EnoPassingViewController.h"

@interface EnoPassingViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral     *peripheral;
@property (nonatomic, strong) NSMutableData    *data;

@property (nonatomic, strong) NSArray *passings;

@end

@implementation EnoPassingViewController

- (id)init
{
    self = [super initWithNibName:@"EnoPassingViewController" bundle:nil];
    
    if ( self ) {
        
        // hogehoge
        self.title = @"すれ違い";
        
        self.passings = [EnoNSUserDefaults getPassings];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableview
     registerNib:[UINib nibWithNibName:@"EnoPassingTableViewCell" bundle:nil]
     forCellReuseIdentifier:@"Cell"];
    
    self.tableview.dataSource = self;
    self.tableview.delegate   = self;
    
    // セントラルマネージャーの起動
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    // 画面切り替え時に最新にしておく
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark - UITableViewDataSource

/**
 * セクションに含まれるセル数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( section == 0 ) {
        
        return 1;
    }
    else {
        
        if ( self.passings ) {
            
            return [self.passings count];
        }
        
        return 0;
    }
}

/**
 * セルの内容を返す
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EnoPassingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ( indexPath.section == 0 ) {
        
        EnoProfileInfo *profile     = [EnoNSUserDefaults getProfileModel];
        cell.nameLabel.text         = profile.name;
        cell.messageLabel.text      = profile.message;
        cell.timeLabel.text         = nil;
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:profile.iconUrlsitring]];
        cell.iconImageView.image = [UIImage imageWithData:data];
    }
    else {
        
        NSDictionary *passing  = [self.passings objectAtIndex:indexPath.row];
        cell.nameLabel.text    = [passing objectForKey:@"name"];
        cell.messageLabel.text = [passing objectForKey:@"message"];
        
        NSDate *passinged   = [passing objectForKey:@"passinged"];
        cell.timeLabel.text = passinged.description;
        
        NSString *imageUrlstring = [passing objectForKey:@"iconUrlstring"];
        NSData   *imageData      = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlstring]];
        cell.iconImageView.image = [UIImage imageWithData:imageData];
    }
    
    return cell;
}

/**
 * テーブルのセクション数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/**
 * ヘッダー
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ( section == 0 ) {
        
        return @"自分のプロフィール";
    }
    else {
        
        return @"すれ違ったひとたち";
    }
}

/**
 * セルの高さ
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

# pragma mark - UITableViewDelegate

# pragma mark - CBCentralManagerDelegate

/**
 * centralManagerが初期化されたり、状態が変化した時
 */
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    
    switch ( central.state ) {
        case CBCentralManagerStatePoweredOn:
            NSLog( @"%@", @"CBCentralManagerStatePoweredOn" );
            // ペリフェラルの走査開始（単一デバイスの発見イベントを重複して発行させない）
            [self.centralManager
             scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:[EnoConst serviceUUID]]]
             options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];
            break;
            
        case CBCentralManagerStatePoweredOff:
            NSLog( @"%@", @"CBCentralManagerStatePoweredOff" );
            break;
            
        case CBCentralManagerStateResetting:
            NSLog( @"%@", @"CBCentralManagerStateResetting" );
            break;
            
        case CBCentralManagerStateUnauthorized:
            NSLog( @"%@", @"CBCentralManagerStateUnauthorized" );
            break;
            
        case CBCentralManagerStateUnsupported:
            NSLog( @"%@", @"CBCentralManagerStateUnsupported" );
            break;
            
        case CBCentralManagerStateUnknown:
            NSLog( @"%@", @"CBCentralManagerStateUnknown" );
            break;
            
        default:
            break;
    }
}

/**
 * デバイス発見時
 */
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    
    NSLog( @"Discovered %@", peripheral.name );
    
    // 省電力のため、他のペリフェラルの走査は停止する
    [self.centralManager stopScan];
    NSLog(@"Scanning stopped");
    
    NSLog( @"[RSSI] %@", RSSI );
    
    if ( self.peripheral != peripheral ) {
        
        // 発見されたデバイスに接続
        self.peripheral = peripheral;
        NSLog( @"Connecting to pripheral %@", peripheral );
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

/**
 * ペリフェラル（情報を発信する側）が無事に接続された時
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // メソッド名表示
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    NSLog( @"%@", peripheral.description );
    
    // データの初期化
    [self.data setLength:0];
    
    // デリゲート設定
    self.peripheral.delegate = self;
    
    // サービスの探索を開始
    [self.peripheral discoverServices:@[[CBUUID UUIDWithString:[EnoConst serviceUUID]]]];
}

# pragma mark - CBPeripheralDelegate

/**
 * ペリフェラルの利用可能なサービスが見つかった
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    
    if ( error ) {
        
        NSLog( @"[error] %@", [error localizedDescription] );
        return;
    }
    
    for ( CBService *service in peripheral.services ) {
        
        NSLog( @"Service found with UUID: %@", service.UUID );
        
        if ( [service.UUID isEqual:[CBUUID UUIDWithString:[EnoConst serviceUUID]] ] ) {
            
            NSLog( @"discover characteristic!" );
            
            // サービスの特性を検出する
            [self.peripheral
             discoverCharacteristics:@[[CBUUID UUIDWithString:[EnoConst characteristicUUID]]]
             forService:service];
        }
    }
}

/**
 * 指定したサービスのCharacteristicsを見つけた
 */
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    
    if ( error ) {
        
        NSLog( @"[error] %@", [error localizedDescription] );
        return;
    }
    
    if ( [service.UUID isEqual:[CBUUID UUIDWithString:[EnoConst serviceUUID]]] ) {
        
        for ( CBCharacteristic *characteristic in service.characteristics ) {
            
            NSLog( @"characteristices is found!" );
            
            // 特性の値を読み取る
            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

/**
 * characteristicの値が変更された
 */
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    
    if ( error ) {
        
        NSLog( @"[error] %@", [error localizedDescription] );
        return;
    }
    
    NSLog( @"no error" );
    
    NSData *data = characteristic.value;
    NSLog( @"[data] %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] );
    
    // すれ違い一覧更新
    [EnoNSUserDefaults addPassingsWithJsondata:data];
    self.passings = [EnoNSUserDefaults getPassings];
    
    [self.tableview reloadData];
    
    [self.centralManager cancelPeripheralConnection:peripheral];
}

/**
 * 周辺機器が起動したり、characteristicの値の通知の提供を停止する要求を受け取ったとき
 */
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    NSLog( @"%@", NSStringFromSelector(_cmd) );
    
    if ( error ) {
        
        NSLog( @"[error] %@", [error localizedDescription] );
        return;
    }
    
    if ( ![characteristic.UUID isEqual:[CBUUID UUIDWithString:[EnoConst characteristicUUID]]] ) {
        
        return ;
    }
    
    if ( characteristic.isNotifying ) {
        
        NSLog( @"Notification began on %@", characteristic );
        [peripheral readValueForCharacteristic:characteristic];
    }
    else {
        
        NSLog( @"Notification stopped on %@. Disconnecting", characteristic );
        [self.centralManager cancelPeripheralConnection:self.peripheral];
    }
}

@end
