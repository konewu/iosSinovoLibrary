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
#import "SYIToast+SYCategory.h"
#import <iosSinovoLib/iosSinovoLib.h>

@interface httpCallback ()<HttpDelegate>

@end
extern IOAppDelegate *myDelegate;
NSString *access_token;
NSString *app_publish_topic;
NSString *app_subscribe_topic;

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
        [[HttpLib sharedHttpLib] httpGetDFUInfo:NO];
    });
}

- (void) getLockTypeInfo {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] httpGetLockType];
    });
}

- (void) getLockTypeImage :(NSString *)url :(NSString *)lockType {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] httpGetLockImage:url :lockType];
    });
}

- (void) downloadDfuFile :(NSString *)filename {
    [HttpLib sharedHttpLib].delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[HttpLib sharedHttpLib] downloadDfuFile :NO :filename];
    });
}

#pragma mark - callback

- (void)onGetLockList :(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"OnGetLockList： %@", pNSDictionary);
}

- (void)onGetGwList:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"OnGetGwList： %@", pNSDictionary);
}

- (void)onAddGateway:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onAddGateway： %@", pNSDictionary);
}

- (void)onAddLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onAddLock： %@", pNSDictionary);
}

- (void)onAddShareData:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onAddShareData： %@", pNSDictionary);
}

- (void)onDelGateway:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onDelGateway： %@", pNSDictionary);
}

- (void)onDelLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onDelLock： %@", pNSDictionary);
}

- (void)onDelShareData:(nonnull NSDictionary *)pNSDictionary {
    
}

- (void)onGetShareData:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onGetShareData： %@", pNSDictionary);
}

- (void)onGetVerifyCode:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onGetVerifyCode： %@", pNSDictionary);
}

- (void)onModifyPass:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onModifyPass： %@", pNSDictionary);
}

- (void)onModifyGwName:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onModifyGwName： %@", pNSDictionary);
}

- (void)onShareLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onShareLock ： %@", pNSDictionary);
}

- (void)onUpdateLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onUpdateLock： %@", pNSDictionary);
}

- (void)onUpdateLoginUserInfo:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onUpdateLoginUserInfo： %@", pNSDictionary);
}

- (void)onUpdateShareData:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onUpdateShareData： %@", pNSDictionary);
}

- (void)onUpdateUserAvatar:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onUpdateUserAvatar： %@", pNSDictionary);
}

- (void)onUserLoign:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onUserLoign： %@", pNSDictionary);
    if ([pNSDictionary objectForKey:@"access_token"]) {
        access_token = [pNSDictionary objectForKey:@"access_token"];
        NSString *app_deviceName = [pNSDictionary objectForKey:@"app_deviceName"];
        NSString *app_deviceSecret = [pNSDictionary objectForKey:@"app_deviceSecret"];
        NSString *app_productKey = [pNSDictionary objectForKey:@"app_productKey"];
        app_publish_topic = [pNSDictionary objectForKey:@"app_publish_topic"];
        NSString *app_region = [pNSDictionary objectForKey:@"app_region"];
        app_subscribe_topic = [pNSDictionary objectForKey:@"app_subscribe_topic"];
        
        [[mqttCallBack sharedMqttCallBack] MqttInit:app_productKey :app_deviceName :app_deviceSecret :app_region ];
        
        NSString *result = [NSString stringWithFormat:@"deviceName:%@\ndeviceSecret:%@\nproductKey:%@\nregion:%@\n\n register mqtt now  ......",app_deviceName, app_deviceSecret, app_productKey, app_region];
        
        myDelegate.resultTV.text = result;
    }else {
        myDelegate.resultTV.text = [self DictionaryTostring:pNSDictionary];
    }
   
}

- (void)onUserRegister :(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onUserRegister： %@", pNSDictionary);
}

- (void)onHttpGetUserAvatar :(nonnull id) object {
    if ([object isKindOfClass:[NSData class]]){
        NSLog(@"download avatar success %@", object);
    }
    
    if ([object isKindOfClass:[NSDictionary class]]){
        if ([object objectForKey:@"error"]) {
        NSLog(@"failed to download avatar");
        }
    }
}

- (void)onHttpGetLockImage :(nonnull id) object {
    if ([object isKindOfClass:[NSDictionary class]]){
        if ([object objectForKey:@"locktype"]) {
            NSLog(@"download lockimage success ");
        }
    }
}

- (void)onResetLock:(nonnull NSDictionary *)pNSDictionary {
    NSLog(@"onResetLock ： %@", pNSDictionary);
}

- (void)onHttpGetDfuVerion:(nonnull id)object {
    if ([object objectForKey:@"dfu_list"]) {
        NSLog(@"DFU info %@", object);
        
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            NSString *result_old = myDelegate.resultTV.text;
            myDelegate.resultTV.text = [NSString stringWithFormat:@"%@\n\nhttp get dfu info: %@", result_old, object];
            [myDelegate.resultTV scrollRangeToVisible:NSMakeRange(myDelegate.resultTV.text.length, 1)];
        });
     
        NSArray *dfulist = [object objectForKey:@"dfu_list"];
        for (NSDictionary *turnDic in dfulist) {
            NSString *dfu_file  = [turnDic valueForKey:@"dfu_file"];
            NSString *fmversion = [turnDic valueForKey:@"fmversion"];
            NSString *lockType  = [turnDic valueForKey:@"lockType"];
            
            if ([myDelegate.locktype isEqualToString:lockType]) {
                NSArray *array1 = [myDelegate.firmwareVersion componentsSeparatedByString:@"."];
                NSArray *array2 = [fmversion componentsSeparatedByString:@"."];
                if (array1.count != 3 || array2.count != 3) {
                    NSLog(@"error, firmware is error");
                    return;
                }
                int oldver = [array1[2] intValue];
                int newver = [array2[2] intValue];
                
                if (newver > oldver) {
                    dispatch_queue_t mainQueue = dispatch_get_main_queue();
                    dispatch_async(mainQueue, ^{
                        NSString *result_old = myDelegate.resultTV.text;
                        myDelegate.resultTV.text = [NSString stringWithFormat:@"%@\n\nDownload DFU file now....", result_old];
                        [myDelegate.resultTV scrollRangeToVisible:NSMakeRange(myDelegate.resultTV.text.length, 1)];
                    });
                    [self downloadDfuFile :dfu_file];
                }else {
                    dispatch_queue_t mainQueue = dispatch_get_main_queue();
                    dispatch_async(mainQueue, ^{
                        NSString *result_old = myDelegate.resultTV.text;
                        myDelegate.resultTV.text = [NSString stringWithFormat:@"%@\n\nFirmware is the latest version, no need to update", result_old];
                        [myDelegate.resultTV scrollRangeToVisible:NSMakeRange(myDelegate.resultTV.text.length, 1)];
                    });
                    NSLog(@"Firmware is the latest version");
                }
            }
        }
    }
}

- (void)onHttpGetLockType:(nonnull id)object {
    if ([object objectForKey:@"lockTypeList"]) {
        NSLog(@"Download Lock Info: %@", object);
        NSArray *lockTypeList = [object objectForKey:@"lockTypeList"];
        for (NSDictionary *turnDic in lockTypeList) {
            NSString *locktype   = [turnDic valueForKey:@"locktype"];
            [myDelegate.lockTypeArray addObject:locktype];
        }
    }
}

- (void)onDownloadDfuFile:(nonnull NSString *)filepath {
    NSLog(@"DFU file：%@", filepath);
    myDelegate.dfuFilePath = filepath;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSString *result_old = myDelegate.resultTV.text;
        myDelegate.resultTV.text = [NSString stringWithFormat:@"%@\n\nDownload the upgrade package successfully，file：%@", result_old, filepath];
        
        [myDelegate.resultTV scrollRangeToVisible:NSMakeRange(myDelegate.resultTV.text.length, 1)];
        NSString *message = @"Download the upgrade package successfully";
        [SYIToast alertWithTitle:message];
    });
}

//Nsstring parse to NSDictionary
- (NSDictionary *)StringToDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    if(err) {
        NSLog(@"Json Parsing failed：%@",err);
        return nil;
    }
    return dic;
}

//NSDictionary parse to Nsstring
-(NSString *)DictionaryTostring:(NSDictionary *)dict {
    BOOL isYes = [NSJSONSerialization isValidJSONObject:dict];
    NSString * result;
    if (isYes){
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:NULL];
        [jsonData writeToFile:@"/Users/SunnyBoy/Sites/JSON_XML/dict.json" atomically:YES];
        result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    else{
        result = @"Json error";
        NSLog(@"Json error");
    }
    return result;
}

@end
