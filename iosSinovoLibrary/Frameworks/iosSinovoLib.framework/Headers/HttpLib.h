//
//  HttpLib.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/4/25.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//定义 Delegate 协议
@protocol HttpDelegate <NSObject>
- (void)onUserLoign  :(NSDictionary *)pNSDictionary;
- (void)onUserRegister  :(NSDictionary *)pNSDictionary;
- (void)onGetVerifyCode  :(NSDictionary *)pNSDictionary;
- (void)onModifyPass  :(NSDictionary *)pNSDictionary;
- (void)onAddGateway :(NSDictionary *)pNSDictionary;
- (void)onDelGateway :(NSDictionary *)pNSDictionary;
- (void)onModifyGwName :(NSDictionary *)pNSDictionary;
- (void)onGetGwList  :(NSDictionary *)pNSDictionary;
- (void)onAddLock :(NSDictionary *)pNSDictionary;
- (void)onUpdateLock :(NSDictionary *)pNSDictionary;
- (void)onGetLockList:(NSDictionary *)pNSDictionary;
- (void)onDelLock :(NSDictionary *)pNSDictionary;
- (void)onUpdateLoginUserInfo :(NSDictionary *)pNSDictionary;
- (void)onUpdateUserAvatar :(NSDictionary *)pNSDictionary;
- (void)onShareLock :(NSDictionary *)pNSDictionary;
- (void)onAddShareData :(NSDictionary *)pNSDictionary;
- (void)onGetShareData :(NSDictionary *)pNSDictionary;
- (void)onUpdateShareData :(NSDictionary *)pNSDictionary;
- (void)onDelShareData :(NSDictionary *)pNSDictionary;
- (void)onResetLock :(NSDictionary *)pNSDictionary;

- (void)onHttpGetUserAvatar :(id)object;        //http get 请求用户的头像数据
- (void)onHttpGetDfuVerion :(id)object;         //http get 请求获取dfu升级包的信息
- (void)onHttpGetLockType :(id)object;          //http get 请求获取锁型号的信息
- (void)onHttpGetLockImage :(id)object;          //http get 请求获取锁型号 对应的图片

- (void)onDownloadDfuFile :(NSString *)filepath;

@end

@interface HttpLib : NSObject {
    NSObject<HttpDelegate> *delegate;
    NSString *access_Token;
}

@property (strong, nonatomic) NSObject<HttpDelegate> *delegate;

+ (instancetype) sharedHttpLib;

- (void) userRegister :(NSString *)account :(NSString *)password ;
- (void) userLogin :(NSString *)account :(NSString *)password ;
- (void) getVerfyCode :(NSString *)account ;
- (void) modifyPass :(NSString *)account :(NSString *)verifycode :(NSString *)newPass;
- (void) addGateway :(NSString *)gatewayID :(NSString *)gatewayName ;
- (void) delGateway :(NSString *)gatewayID ;
- (void) modifyGWName :(NSString *)gatewayID :(NSString *)gatewayName ;
- (void) getGatewayList ;
- (void) addLock :(NSMutableDictionary *)jsonData ;
- (void) updateLock :(NSMutableDictionary *)jsonData ;
- (void) getLockList ;     
- (void) delLock :(NSString *)lockId ;
- (void) updateLoginUserInfo :(NSString *)nickname :(NSString *)age :(NSString *)address :(NSString *)shake_unlock :(NSString *)vibration ;
- (void) updateUserAvatar :(NSString *)imgBase64;
- (void) shareLock :(NSMutableDictionary *)jsondata;
- (void) addShareData :(NSMutableDictionary *)jsondata;
- (void) getShareDataList :(NSMutableDictionary *)jsondata;
- (void) updateShareData :(NSMutableDictionary *)jsondata;
- (void) delShareData :(NSString *)jsondata;
- (void) resetLock :(NSString *)lockID;

- (void) httpGetUserAvatar :(NSString *)url ;
- (void) httpGetLockType ;
- (void) httpGetDFUInfo :(BOOL)isRelease ;  
- (void) httpGetLockImage :(NSString *)url :(NSString *)lockType;

- (void) downloadDfuFile :(BOOL)isRelease :(NSString *)url ;
@end

NS_ASSUME_NONNULL_END
