//
//  ViewController.m
//  bluetooth
//
//  Created by  王伟 on 16/8/13.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic,strong) CBCentralManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager  = [[CBCentralManager alloc] initWithDelegate:self queue:nil];  ;
    
    
}
#pragma mark - CBCentralManagerDelegate 
//检查蓝牙设备是否准备完毕
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == 5) {
        NSLog(@"蓝牙设备已经准备完毕");
        //扫描蓝牙设备
        [self.manager scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"%@",peripheral);
    NSLog(@"%@",RSSI);
    if ([peripheral.name isEqualToString:@"My Mambo"]) {
        [self.manager stopScan];
        [self.manager connectPeripheral:peripheral options:nil];
    }
}

// 连接到外设后
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"已经连接到:%@", peripheral.description);
//    peripheral.delegate = self;
//    [central stopScan];
//    [peripheral discoverServices:nil];
}

// 连接失败后
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接失败");
}
// 断开外设
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"断开外设");
}


@end
