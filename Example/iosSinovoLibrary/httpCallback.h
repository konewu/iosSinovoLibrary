//
//  httpCallback.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/4/24.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface httpCallback : NSObject {

}

+ (instancetype) sharedHttpCallback;
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
- (void) getDfuInfo ;
- (void) getLockTypeInfo ;   //获取服务器上 有的所有锁
- (void) getLockTypeImage :(NSString *)url :(NSString *)lockType ;   //获取指定锁类型的图片
- (void) downloadDfuFile :(NSString *)filename;

@end


NS_ASSUME_NONNULL_END
