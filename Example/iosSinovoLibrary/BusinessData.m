//
//  BusinessData.m
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/21.
//  Copyright © 2021 kone. All rights reserved.
//

#import "IOAppDelegate.h"
#import "BusinessData.h"
#import <iosSinovoLib/iosSinovoLib.h>
#import <AudioToolbox/AudioToolbox.h>

@interface BusinessData ()

@end
extern IOAppDelegate *myDelegate;

@implementation BusinessData

// 单例的实例化方法
+(instancetype) shared {
    static id _instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });

    return _instance;
}

//通过二维码来连接锁的时候，结果回调在此处理
- (void) onConnectLockViaQRCode :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，通过二维码连接锁, 结果%@", dict);
    
//    myDelegate.resultTV.text = [NSString stringWithFormat:@"%@", dict];
    NSString *errCode = [dict objectForKey:@"errCode"];
    if ([errCode isEqualToString:@"00"] || [errCode isEqualToString:@"0b"]) {
        myDelegate.bleConnected = YES;
        myDelegate.blestatusLb.text = @"Connected";
        myDelegate.blestatusLb.textColor = [UIColor blueColor];
        myDelegate.blestatusLb_dfu.text = @"Connected";
        myDelegate.blestatusLb_dfu.textColor = [UIColor blueColor];
        
        if (dict.count > 2 && ![dict objectForKey:@"autoCreateUser"] ) {
            myDelegate.lockSno = [dict objectForKey:@"lockSno"];
        }
        
        if ([dict objectForKey:@"autoCreateUser"] ) {
            //等待绑定成功，写入数据库后，更新homeUI页面显示，再返回首页，并取消进度条
            [[SinovoBle sharedBLE] getLockInfo:2 :myDelegate.lockSno];      //获取电量
            [[SinovoBle sharedBLE] getLockInfo:3 :myDelegate.lockSno];      //获取锁的状态，是否已经解锁
            [[SinovoBle sharedBLE] getLockInfo:4 :myDelegate.lockSno];      //获取硬件信息

        }
        return;
    }
}


//开关门
- (void) onUnlock :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，开关门回调，数据：%@", dict);
}

//创建用户
- (void) onCreateUser :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，创建用户回调 内容：%@", dict);
}

//更新用户信息
- (void) onUpdateUser :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，编辑用户回调,内容：%@", dict);
}

//添加数据
- (void) onAddData :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，添加数据回调，数据：%@", dict);
}


//删除数据回调
- (void) onDelData :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，删除数据回调， 数据：%@", dict);
}


//密码登录验证
- (void) onVerifyCode :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，验证密码的回调， 结果：%@", dict);
}


//清除用户数据， 恢复出厂设置
- (void) onCleanData :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，清除数据回调， 数据：%@", dict);
}


//获取锁端的 信息
- (void) onLockInfo :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，查询锁的属性回调， 结果：%@", dict);
    NSString *errCode = [dict objectForKey:@"errCode"];
    
    if ([errCode isEqualToString:@"00"]) {
        NSString *funCode = [dict objectForKey:@"funCode"];
        
        //DFU ota 升级
        if ([funCode isEqualToString:@"19"]) {
            [[SinovoBle sharedBLE] startToDFU];
            myDelegate.isDFUMode = YES;
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                NSString *result_old = myDelegate.resultTV.text;
                myDelegate.resultTV.text = [NSString stringWithFormat:@"%@\n\nStart to DFU....", result_old];
            });
        }
        
        //查询锁的固件信息，版本和硬件类型
        if ([funCode isEqualToString:@"1a"]) {
            NSString *VER1 = [dict objectForKey:@"fwVersion1"];
            NSString *VER2 = [dict objectForKey:@"fwVersion2"];
            NSString *VER_TIME = [dict objectForKey:@"fwVerTime"];
            NSString *HW_TYPE = [dict objectForKey:@"fwType"];
            
            if ([HW_TYPE isEqualToString:@"03"]) { myDelegate.locktype = @"FM60B";}
            if ([HW_TYPE isEqualToString:@"04"]) { myDelegate.locktype = @"FM67";}
            if ([HW_TYPE isEqualToString:@"05"]) { myDelegate.locktype = @"FM810";}
            if ([HW_TYPE isEqualToString:@"06"]) { myDelegate.locktype = @"FM68";}
            
            NSString *Version = [NSString stringWithFormat:@"%d.%d.%@", [VER1 intValue], [VER2 intValue], VER_TIME];
            myDelegate.firmwareVersion = Version;
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                NSString *result_old = myDelegate.resultTV.text;
                myDelegate.resultTV.text = [NSString stringWithFormat:@"%@\n\nget lock Firmware, locktype:%@, version:%@", result_old, myDelegate.locktype, Version];
            });
        }
    }
    
}


//同步用户数据
- (void) onRequestData :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，请求同步数据回调，结果：%@",dict);
    
}

//同步日志
- (void) onRequestLog :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，请求日志数据回调，结果：%@",dict);
    
}

//分享密码的状态
- (void) onDynamicCodeStatus :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，启用禁用动态密码的回调 ，结果：%@",dict);
}

//锁锁死3分钟
- (void) onLockFrozen :(NSMutableDictionary *)dict {
    NSLog(@"回调通知，当前锁为锁死状态，结果：%@",dict);
}

//锁 死锁结束
- (void) finishFrozen {
    [[SinovoBle sharedBLE] getLockInfo :2 :myDelegate.lockSno];
}

- (void) errSnoToDO {
    
    NSLog(@"sno 错误，需要用户重新添加此锁， 将锁的SNO重置为空");
   
}


@end
