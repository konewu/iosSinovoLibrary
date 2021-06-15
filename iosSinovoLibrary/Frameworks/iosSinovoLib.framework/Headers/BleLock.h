//
//  BleLock.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/4.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface BleLock : NSObject
@property (nonatomic, strong) CBPeripheral *mPeripheral;   //记录下当前连接的外设对象
@property (nonatomic) NSString* qrCode;                     //锁的二维码，自动连接时，必须填此参数
@property (nonatomic) NSString* deviceName;
@property (nonatomic) NSString* uuid;
@property (nonatomic) NSString* lockmac;             //锁的蓝牙mac地址，自动连接时，必须填此参数
@property (nonatomic) NSString* SNO;                 //蓝牙通信的密钥，自动连接时，必须填此参数
@property (nonatomic) int  BleADV;                   //兼容旧的锁，0 表示没有此锁不会发广播，1表示有广播，2表示未知（添加锁的时候设置为2）
@end

NS_ASSUME_NONNULL_END
