//
//  SinovoBle.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/2.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "BleLock.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BleDelegate <NSObject>
- (void) onBleStatusUnknown;
- (void) onBluetoothOn;
- (void) onBluetoothOff;
- (void) onLockFound :(BleLock *)bleDevice;                    //扫描回调,发现设备的回调
- (void) onScanOnlyFinish ;                                    //仅仅扫描的回调，不会去自动连接
- (void) onConnectLockViaQRCodeTimeOut;                        //连接超时
- (void) onConnectFailure;                                     //连接失败
- (void) onBleDisconnect :(CBPeripheral *)peripheral;          //连接断开
- (void) onConnectLockViaQRCode :(NSMutableDictionary *)dict;  //连接方式一，通过扫描来添加锁的结果
- (void) onConnectLockViaMacSno :(NSMutableDictionary *)dict;  //连接方式二，直接通过mac地址和sno来连接锁

//数据处理部分
- (void) onCreateUser :(NSMutableDictionary *)dict;
- (void) onUpdateUser :(NSMutableDictionary *)dict;
- (void) onAddData :(NSMutableDictionary *)dict;
- (void) onDelData :(NSMutableDictionary *)dict;
- (void) onVerifyCode :(NSMutableDictionary *)dict;
- (void) onUnlock :(NSMutableDictionary *)dict;
- (void) onCleanData :(NSMutableDictionary *)dict;
- (void) onLockInfo :(NSMutableDictionary *)dict;
- (void) onRequestData :(NSMutableDictionary *)dict;
- (void) onRequestLog :(NSMutableDictionary *)dict;
- (void) onDynamicCodeStatus :(NSMutableDictionary *)dict;
- (void) onLockFrozen :(NSMutableDictionary *)dict;

@end

@interface SinovoBle : NSObject {
  
}

@property (nonatomic, strong) CBCentralManager *mCentral;
@property (nonatomic, strong) CBPeripheral *mPeripheral;
@property (nonatomic, strong) CBCharacteristic *mCharacteristic;
@property (nonatomic, strong) CBService *mService;
@property (nonatomic, strong) CBDescriptor *mDescriptor;

@property (nonatomic) BOOL blueEnable;
@property (nonatomic) BOOL isBindMode;
@property (nonatomic) BOOL isConnecting;
@property (nonatomic) BOOL isConnected;
@property (nonatomic) BOOL connectNoQrcode;     //没有二维码时连接，兼容老锁

@property (nonatomic) NSString *userIMEI;
@property (nonatomic) NSString *firmVersion;
@property (nonatomic) NSString *hwType;

@property (nonatomic) NSMutableArray *ReconnectList;        //蓝牙连接断开后，自动重连列表
@property (nonatomic) NSMutableArray *BlackList;            //连接黑名单，绑定的时候，对于二维码不匹配的锁，需要加入到二维码中，加入外设 CBPeripheral

@property (nonatomic, strong) NSObject<BleDelegate> *delegate;
@property (nonatomic, strong) NSTimer *bindTimer;           //添加锁的时候，超时检测
@property (nonatomic, copy) BleLock *connectingBleLock;

//初始化蓝牙
- (CBCentralManager *) centralInit;

//- (void) sendData :(NSData *)data;
- (void) bleScanOnly;
- (void) cancelConnectLock ;  
- (void) connectLockViaQRCode :(NSString *)qrcode :(NSString *)userIMEI;   //参数为 需要连接的锁的二维码
- (void) connectLockViaMacSno :(NSMutableArray *)autoConnectLockList;

- (void) addUser :(NSString *)username ;
- (void) updateUserName :(NSString *)username :(NSString *)userNID ;
- (void) addDataForUser :(NSString *)userNID :(NSString *)dataType :(NSString *)data ;
- (void) delData :(NSString *)dataType :(NSString *)delID ;
- (void) resetCode :(NSString *)userNID :(NSString *)codeType :(NSString *)codeID :(NSString *)newCode ;
- (void) setLockInfo :(int)dataType :(NSString *)data ;
- (void) getLockInfo :(int)dataType ;
- (void) getAllUsers ;
- (void) getLog :(NSString *)logID ;
- (void) doDynamicCode :(NSString *)code :(NSString *)enable;
- (void) updateCodeType :(NSString *)oldCodeType :(NSString *)codeID :(NSString *)newCodeType;
- (void) verifyCode :(NSString *)code ;
- (void) toUnlock :(NSString *)dataType :(NSString *)code ;
- (NSString *) getUnlockData :(NSString *)code ;        //获取开门的数据，主要用于多把锁绑定于网关下进行联动开门
- (void) cleanData :(NSString *)dataType ;
- (void) toDisconnBle ;

//-(void) setLockMac :(NSString*)mac;
//-(void) setLockSno :(NSString*)sno;
//
//-(NSString *) getLockMac ;
//-(NSString *) getLockSno ;

-(void) startToDFU ;    //开始进行升级 , 扫描的 uuid 为dfu的 uuid FE59
-(void) finishiDFU ;    //升级完成，需要通知库， 这样才能重新进行自动连接

//实例化mqtt 对象
+(instancetype) sharedBLE;

@end



NS_ASSUME_NONNULL_END
