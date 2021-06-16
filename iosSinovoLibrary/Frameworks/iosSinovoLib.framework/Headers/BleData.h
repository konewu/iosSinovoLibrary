//
//  BleData.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/4.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BleData : NSObject {
    
}

@property (nonatomic) NSString *lockmac;
@property (nonatomic) NSString *lockSno;
@property (nonatomic) BOOL isSending;
@property (nonatomic) NSString *sendTime;                       //命令发送 的时间
@property (nonatomic,strong) NSMutableArray *commandList;       //用于存放需要执行的命令
@property (nonatomic,strong) dispatch_queue_t sendcmdQueue;     //定义队列，异步串行队列，用于启动子线程来执行命令

+ (instancetype) sharedBleData;

- (void) initBleData ;

- (void) sendData:(NSData *)data ;

/* 收到蓝牙发送过来的数据，首先在此函数进行处理 */
-(NSMutableDictionary*) receiveDataFromBle :(NSString *)bledata :(NSString *)lockmac;

/* 将字符串转换为 16进制的 ascii 吗 */
- (NSString *)strToHexAscii :(NSString *)sourceStr;

/* 解析蓝牙端返回的数据 */
- (NSMutableDictionary*)parseData :(NSString *)sourceData :(NSString *)lockmac;

/* 将字符串转为 bcd码 **/
- (NSData *)bcdDataForString:(NSString *)bcdstr;

/* 执行发送命令 ***/
- (void)exeCmd :(NSString *)funCode :(NSString *)data :(BOOL)insertTop;

//处理数据，进行加解密处理
- (NSString *)subpackage :(NSString *)FunCode :(NSString *)Content :(NSString *)mac :(BOOL)insertTop :(BOOL)isExe;

/* 将十进制转换为十六进制 ***/
- (NSString *)getHexByDecimal:(NSInteger)decimal;

-(void) setLockMac :(NSString*)mac;
-(void) setLockSno :(NSString*)sno;

-(NSString *) getLockMac ;
-(NSString *) getLockSno ;

@end

NS_ASSUME_NONNULL_END
