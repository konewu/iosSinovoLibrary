//
//  SinovoBleCallBack.m
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/3.
//  Copyright © 2021 kone. All rights reserved.
//

#import "IOAppDelegate.h"
#import "SinovoBleCallBack.h"
#import "BusinessData.h"
#import <iosSinovoLib/iosSinovoLib.h>

@interface SinovoBleCallBack ()<BleDelegate>

@end

extern IOAppDelegate *myDelegate;
@implementation SinovoBleCallBack

// 单例的实例化方法
+(instancetype) sharedBleCallBack {
    static id _instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });

    return _instance;
}

//初始化SinovoBle 蓝牙
- (void) InitBle {
    [SinovoBle sharedBLE].delegate = self;
    [[SinovoBle sharedBLE] centralInit];
}

#pragma mark - 回调 的处理
//蓝牙扫描的回调
- (void)onLockFound:(nonnull BleLock *)bleDevice {
    NSLog(@"回调通知，蓝牙扫描的结果回调，qrcode：%@， name：%@, uuid:%@", bleDevice.qrCode, bleDevice.deviceName, bleDevice.uuid);
}

/**
 执行升级文件发送到固件操作
 */
- (void)uploadFileToBlueDevice:(NSURL *)filePath :(CBPeripheral *)peripheral{

    NSLog(@"开始向锁端上传 dfu升级文件 %@", filePath);
    //create a DFUFirmware object using a NSURL to a Distribution Packer(ZIP)
//    DFUFirmware *selectedFirmware = [[DFUFirmware alloc] initWithUrlToZipFile:filePath];// or
//    //Use the DFUServiceInitializer to initialize the DFU process.
//
////    [[DFUServiceInitiator alloc] initWithQueue:self delegateQueue:self progressQueue:self loggerQueue:self];
//
//    DFUServiceInitiator *initiator = [[DFUServiceInitiator alloc] initWithCentralManager: [SinovoBle sharedBLE].mCentral target:peripheral];
//
//    [initiator withFirmware :selectedFirmware];
//    // Optional:
//    // initiator.forceDfu = YES/NO; // default NO
//    // initiator.packetReceiptNotificationParameter = N; // default is 12
//    initiator.logger = self; // - to get log info
//    initiator.delegate = self; // - to be informed about current state and errors
//    initiator.progressDelegate = self; // - to show progress bar
//    // initiator.peripheralSelector = ... // the default selector is used
//
//   // DFUServiceController *controller = [initiator start];
//
//    DFUServiceController *controller = [initiator startWithTarget:peripheral];
    
}

#pragma mark - LoggerDelegate
//- (void)logWith:(enum LogLevel)level message:(NSString *)message{
//    NSLog(@"logWith---------level = %ld,-------message,%@",(long)level,message);
//}
#pragma mark - DFUServiceDelegate


#pragma mark - DFUProgressDelegate

//- (void)dfuProgressDidChangeFor:(NSInteger)part outOf:(NSInteger)totalParts to:(NSInteger)progress currentSpeedBytesPerSecond:(double)currentSpeedBytesPerSecond avgSpeedBytesPerSecond:(double)avgSpeedBytesPerSecond{
//
//    NSLog(@"升级中...%zd %%",progress);
//    myDelegate.progressView.progress = progress * 0.01;
//    myDelegate.progressLabel.text = [NSString stringWithFormat:@"Upgrading：%zd %%",progress];
//}

//- (void)dfuStateDidChangeTo:(enum DFUState)state{
//    NSLog(@"dfuStateDidChangeTo-----------state = %ld",(long)state);
//    if (state == 0) {
//        myDelegate.progressLabel.text = [NSString stringWithFormat:@"Connecting lock"];
//    }if (state == 1) {
//        myDelegate.progressLabel.text = [NSString stringWithFormat:@"Start to uploading"];
//    }
//    if (state == 6) {
//        myDelegate.progressLabel.text = [NSString stringWithFormat:@"Firmware upgrade completed"];
//        [myDelegate.progressBtn setTitle:@"OK" forState:UIControlStateNormal];
//        [myDelegate.progressBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
//        [myDelegate.progressBtn setEnabled:YES];
//        //需要通知 库，dfu 升级完成了
//        [[SinovoBle sharedBLE] finishiDFU];
//        myDelegate.isDFUMode = NO;
//    }
//}

//- (void)dfuError:(enum DFUError)error didOccurWithMessage:(NSString *)message{
//    NSLog(@"dfuError-----------error = %ld,-------------message = %@",(long)error,message);
//
//    myDelegate.progressLabel.text = [NSString stringWithFormat:@"Upgrade failed,please try again in 2 minutes"];
//    myDelegate.progressLabel.textColor = [UIColor redColor];
//    [myDelegate.progressBtn setTitle:@"OK" forState:UIControlStateNormal];
//    [myDelegate.progressBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
//    [myDelegate.progressBtn setEnabled:YES];
//
//    //需要通知 库，dfu 升级完成了
//    [[SinovoBle sharedBLE] finishiDFU];
//    myDelegate.isDFUMode = NO;
//}



//手机蓝牙关闭
- (void)onBluetoothOff {
    NSLog(@"回调通知，手机关闭了蓝牙");
    myDelegate.bluestatusLb.text = @"OFF";
    myDelegate.bluestatusLb.textColor = [UIColor darkTextColor];
    
    myDelegate.blestatusLb.text = @"disconnected";
    myDelegate.blestatusLb.textColor = [UIColor darkTextColor];
}

//手机蓝牙打开
- (void)onBluetoothOn {
    NSLog(@"回调通知，手机开启了蓝牙");
    myDelegate.bluestatusLb.text = @"ON";
    myDelegate.bluestatusLb.textColor = [UIColor blueColor];
}

//手机蓝牙状态未知
- (void)onBleStatusUnknown {
    NSLog(@"回调通知，手机蓝牙的状态 未知");
    myDelegate.bluestatusLb.text = @"OFF";
    myDelegate.bluestatusLb.textColor = [UIColor darkTextColor];
}

//蓝牙连接断开的回调
- (void)onBleDisconnect:(nonnull CBPeripheral *)peripheral {
    NSLog(@"回调通知，蓝牙连接断开");
    
    myDelegate.blestatusLb.text = @"disconnected";
    myDelegate.blestatusLb.textColor = [UIColor darkTextColor];
}

//蓝牙连接失败
- (void)onConnectFailure {
    NSLog(@"回调通知，蓝牙连接失败");
    myDelegate.blestatusLb.text = @"disconnected";
    myDelegate.blestatusLb.textColor = [UIColor darkTextColor];
}

//蓝牙扫描完成, 10秒 扫描完成
- (void)onScanOnlyFinish { 
    NSLog(@"回调通知，仅仅扫描时，扫描结束");
}

//通过二维码来连接锁的时候，结果回调在此处理
- (void) onConnectLockViaQRCode :(NSMutableDictionary *)dict {
    myDelegate.resultTV.text = [NSString stringWithFormat:@"%@", dict];
    [[BusinessData shared] onConnectLockViaQRCode:dict];
}

//通过二维码来连接锁超时 ，超时间为 1分钟
- (void) onConnectLockViaQRCodeTimeOut {
    NSLog(@"绑定锁时，连接超时");
    myDelegate.blestatusLb.text = @"disconnected";
    myDelegate.blestatusLb.textColor = [UIColor darkTextColor];
}

//自动连接成功
- (void) onConnectLockViaMacSno :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，onConnectLockViaMacSno，结果：%@", dict);
    myDelegate.resultTV.text = [NSString stringWithFormat:@"%@", dict];
    if ([dict objectForKey:@"lockMac"]) {
        
        myDelegate.blestatusLb.text = @"Connected";
        myDelegate.blestatusLb.textColor = [UIColor blueColor];
        
        //自动连接成功，获取锁的相关属性
        [[SinovoBle sharedBLE] getLockInfo :2 :myDelegate.lockSno];
    }
}

//创建用户
- (void) onCreateUser :(NSMutableDictionary *)dict {
    [[BusinessData shared] onCreateUser:dict];
}

//更新用户
- (void) onUpdateUser :(NSMutableDictionary *)dict {
    [[BusinessData shared] onUpdateUser :dict];
}

//添加数据
- (void) onAddData :(NSMutableDictionary *)dict {
    [[BusinessData shared] onAddData:dict];
}

//删除数据回调
- (void) onDelData :(NSMutableDictionary *)dict {
    [[BusinessData shared] onDelData:dict];
}

//密码登录验证
- (void) onVerifyCode :(NSMutableDictionary *)dict {
    [[BusinessData shared] onVerifyCode:dict];
}

//开关门
- (void) onUnlock :(NSMutableDictionary *)dict {
    [[BusinessData shared] onUnlock:dict];
}

//清除用户数据， 恢复出厂设置
- (void) onCleanData :(NSMutableDictionary *)dict {
    [[BusinessData shared] onCleanData:dict];
}

//获取锁端的 信息
- (void) onLockInfo :(NSMutableDictionary *)dict {
    [[BusinessData shared] onLockInfo:dict];
}

//同步用户数据
- (void) onRequestData :(NSMutableDictionary *)dict {
    [[BusinessData shared] onRequestData:dict];
}

//同步日志
- (void) onRequestLog :(NSMutableDictionary *)dict {
    [[BusinessData shared] onRequestLog:dict];
}

//分享密码的状态
- (void) onDynamicCodeStatus :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，启用禁用动态密码的回调 ，结果：%@",dict);
    [[BusinessData shared] onDynamicCodeStatus :dict];
}

//锁锁死3分钟
- (void) onLockFrozen :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，当前锁为锁死状态，结果：%@",dict);
    [[BusinessData shared] onLockFrozen:dict];
}

/*
 *  开关门操作
 */
- (void) openOrClose {
    [[SinovoBle sharedBLE] toUnlock: @"01" :@"" :myDelegate.lockSno];
}

@end
