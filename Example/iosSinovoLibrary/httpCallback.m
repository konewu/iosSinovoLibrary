//
//  httpCallback.m
//  BTLock
//
//  Created by Rongkun Wu on 2021/4/24.
//  Copyright © 2021 kone. All rights reserved.
//

#import "httpCallback.h"
#import "mqttCallBack.h"
#import "IOAppDelegate.h"
#import "ViewController.h"
#import <iosSinovoLib/iosSinovoLib.h>

@interface httpCallback ()<HttpDelegate>

@end
extern IOAppDelegate *myDelegate;


@implementation httpCallback

// 单例的实例化方法
+(instancetype)sharedHttpCallback {
    static id _instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });

    return _instance;
}

/*
########################################################
                APIs
########################################################
*/

- (void) userRegister :(NSString *)account :(NSString *)password {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] userRegister :account :password];
    });
}

-(void) userLogin :(NSString *)account :(NSString *)password {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] userLogin:account :password];
    });
}

- (void) getVerfyCode :(NSString *)account {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] getVerfyCode :account];
    });
    
}

- (void) modifyPass :(NSString *)account :(NSString *)verifycode :(NSString *)newPass{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] modifyPass:account :verifycode :newPass];
    });
}

- (void) addGateway :(NSString *)gatewayID :(NSString *)gatewayName{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] addGateway:gatewayID :gatewayName];
    });
}

- (void) delGateway :(NSString *)gatewayID {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] delGateway:gatewayID];
    });
}

- (void) modifyGWName :(NSString *)gatewayID :(NSString *)gatewayName {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] modifyGWName :gatewayID :gatewayName];
    });
}

-(void) getGatewayList {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] getGatewayList];
    });
}

- (void) addLock :(NSMutableDictionary *)dict {
    NSLog(@"add Lock on http server ： %@",dict);
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] addLock:dict];
    });
}

- (void) updateLock :(NSMutableDictionary *)dict {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] updateLock :dict];
    });
}


-(void) getLockList {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] getLockList];
    });
}

- (void) delLock :(NSString *)lockId {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] delLock :lockId];
    });
}

- (void) updateLoginUserInfo :(NSString *)nickname :(NSString *)age :(NSString *)address :(NSString *)shake_unlock :(NSString *)vibration {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] updateLoginUserInfo:nickname :age :address :shake_unlock :vibration];
    });
}

- (void) updateUserAvatar :(NSString *)imgBase64{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] updateUserAvatar :imgBase64];
    });
}

- (void) shareLock :(NSMutableDictionary *)jsondata{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] shareLock :jsondata ];
    });
}

- (void) addShareData :(NSMutableDictionary *)jsondata{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] addShareData :jsondata ];
    });
}

- (void) getShareDataList :(NSMutableDictionary *)jsondata{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] getShareDataList :jsondata ];
    });
}

- (void) updateShareData :(NSMutableDictionary *)jsondata{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] updateShareData :jsondata ];
    });
}

- (void) delShareData :(NSString *)jsondata{
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] delShareData :jsondata ];
    });
}

- (void) resetLock:(NSString *)lockID {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] resetLock :lockID ];
    });
}

- (void) getDfuInfo {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url_ver = @"https://gws.qiksmart.com/dfu_debug/dfu.json";
        [[HttpLib sharedHttpLib] httpGetDFUInfo:url_ver];
    });
}

//获取锁类型的信息
- (void) getLockTypeInfo {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //查询此用户下的网关、锁列表
        NSString *url_ver = @"https://gws.qiksmart.com/locktype/locktype.json";
        [[HttpLib sharedHttpLib] httpGetLockType :url_ver];
    });
}

//获取指定锁类型的图片
- (void) getLockTypeImage :(NSString *)url :(NSString *)lockType {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //查询此用户下的网关、锁列表
        NSString *url_ver = [NSString stringWithFormat:@"%@%@", @"https://gws.qiksmart.com/locktype/", url];
        [[HttpLib sharedHttpLib] httpGetLockImage:url_ver :lockType];
    });
}

//下载ota升级包
- (void) downloadDfuFile :(NSString *)filename {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //查询此用户下的网关、锁列表
        NSString *url_ver = [NSString stringWithFormat:@"%@%@",@"https://gws.qiksmart.com/dfu_debug/", filename];
        [[HttpLib sharedHttpLib] downloadDfuFile :url_ver];
    });
}

#pragma mark - 回调处理

//回调 处理获取锁列表
- (void)onGetLockList :(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 得到的锁列表 OnGetLockList： %@", pNSDictionary);
}

//获取网关列表
- (void)onGetGwList:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 得到的网关列表 OnGetGwList： %@", pNSDictionary);
}


//添加网关，添加失败，则重试
- (void)onAddGateway:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"httplib 添加网关的结果 onAddGateway： %@", pNSDictionary);
}

//往服务器端添加锁的结果 回调
- (void)onAddLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"httplib 添加锁的结果 onAddLock： %@", pNSDictionary);
}

//添加分享的结果
- (void)onAddShareData:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 分享锁的结果 onAddShareData： %@", pNSDictionary);
    
}

// 删除网关
- (void)onDelGateway:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 删除网关 onDelGateway： %@", pNSDictionary);
}

// 删除锁的结果
- (void)onDelLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 删除锁的结果 onDelLock： %@", pNSDictionary);
}

- (void)onDelShareData:(nonnull NSDictionary *)pNSDictionary {
    
}


//获取分享密码的结果
- (void)onGetShareData:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用获取动态密码的结果 onGetShareData： %@", pNSDictionary);
}

//获取验证码
- (void)onGetVerifyCode:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 获取验证码的结果 onGetVerifyCode： %@", pNSDictionary);
}


//修改密码
- (void)onModifyPass:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 修改密码的结果 onModifyPass： %@", pNSDictionary);
}

//修改网关名称
- (void)onModifyGwName:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate onModifyGwName 修改网关名称的 回调 ： %@", pNSDictionary);
}

//分享锁，也就是将密码 分享给指定的用户
- (void)onShareLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate onShareLock 分享锁的 回调 ： %@", pNSDictionary);
}

//更新锁的信息
- (void)onUpdateLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 更新锁的的结果 onUpdateLock： %@", pNSDictionary);
}

//更新登录用户的信息
- (void)onUpdateLoginUserInfo:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 更新用户信息的结果 onUpdateLoginUserInfo： %@", pNSDictionary);
   
}

//更新分享动态密码
- (void)onUpdateShareData:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 更新动态的结果 onUpdateShareData： %@", pNSDictionary);
}

//更新用户头像
- (void)onUpdateUserAvatar:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 更新用户头像的结果 onUpdateUserAvatar： %@", pNSDictionary);
}

//登录的回调
- (void)onUserLoign:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 登录的结果 onUserLoign： %@", pNSDictionary);
}

//注册api的回调
- (void)onUserRegister :(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用delegate 用户注册的结果 onUserRegister： %@", pNSDictionary);
}

//下载图片
- (void)onHttpGetUserAvatar :(nonnull id) object {
    if ([object isKindOfClass:[NSData class]]){
        NSLog(@"下载用户头像成功 %@", object);
    }
    
    if ([object isKindOfClass:[NSDictionary class]]){
        if ([object objectForKey:@"error"]) {
        NSLog(@"下载图片失败");
        }
    }
}

//下载锁型号对应的图片
- (void)onHttpGetLockImage :(nonnull id) object {
    if ([object isKindOfClass:[NSDictionary class]]){
        if ([object objectForKey:@"locktype"]) {
            NSLog(@"下载图片成功");
        }
    }
}

//回复出厂设置
- (void)onResetLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"调用 onResetLock 的结果： %@", pNSDictionary);
}

//下载dfu的 升级 信息
- (void)onHttpGetDfuVerion:(nonnull id)object {
    if ([object objectForKey:@"dfu_list"]) {
        NSLog(@"下载 升级 版本信息 成功 %@", object);
    }
}

// 下载锁类型的信息
- (void)onHttpGetLockType:(nonnull id)object {
    if ([object objectForKey:@"lockTypeList"]) {
        NSLog(@"下载 锁的类型信息 成功 %@", object);
    }
}

//下载dfu升级包
- (void)onDownloadDfuFile:(nonnull NSString *)filepath {
    NSLog(@"下载dfu升级包，路径：%@,  需要提醒用户升级", filepath);
}


@end
