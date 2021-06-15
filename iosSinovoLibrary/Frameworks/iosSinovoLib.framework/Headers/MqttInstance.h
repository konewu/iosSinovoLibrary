//
//  MqttInstance.h
//  BTLock
//
//  Created by kone on 2021/2/5.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MqttDelegate <NSObject>
- (void) onMqttInitSuccess;     //初始化mqtt成功
- (void) onMqttInitFailed;      //初始化mqtt失败
- (void) onSubcribeSuccess;     //订阅主题成功
- (void) onSubcribeFailed;      //订阅主题失败
- (void) onPublishSuccess;      //发布内容成功
- (void) onPublishFailed;       //发布内容失败
- (void) onPublishTimeOut;       //发布内容失败

- (void) onLogoutSuccess;       //反初始化mqtt成功，注销时调用
- (void) onLogoutFailed;        //反初始化mqtt成功，注销时调用

- (void) onConnected;           //连接成功
- (void) onConnectionLost;      //连接断开，连接丢失
- (void) onMsgArrived :(NSString *)topic :(id) msg;

@end

@interface MqttInstance : NSObject {
    NSObject<MqttDelegate> *delegate;
    BOOL isMqttOK;
}

@property (strong, nonatomic) NSObject<MqttDelegate> *delegate;

//实例化mqtt 对象
+(instancetype) sharedMqtt;

//初始化mqtt
-(void) MqttInit :(NSString *)productKey :(NSString *)deviceName :(NSString *)deviceSecret :(NSString *)region;

//注销退出
-(void) logoutMQTT;

//取消订阅
-(void) unSubscriptTopic;

#pragma mark - 业务逻辑部分
//通知网关，断开与锁的蓝牙连接， 
-(void) disconnectLock :(NSString *)gatewayid :(NSMutableArray *)macList ;

//添加用户
-(void) addUser :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)userName;

//修改用户名称
-(void) updateUserName :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)userName :(NSString *)userNid ;

//为用户添加一组数据
-(void) addDataForUser :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)userNid :(NSString *)dataType :(NSString *)password ;

//删除数据
-(void) delData :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)dataType :(NSString *)delID ;

//修改密码
-(void) resetCode :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)userNid :(NSString *)codeType :(NSString *)codeID :(NSString *)newCode ;

//设置锁的属性
-(void) setLockInfo :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(int)datatype  :(NSString *)data ;

//查询锁的属性
-(void)getLockInfo :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(int)datatype;

//同步用户
-(void) getAllUsers :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno;

//同步日志
-(void) getLog :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)logID ;

//启用、禁用动态密码
-(void) doDynamicCode :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)dynamicCode :(NSString *)enable ;

//修改密码类型
-(void) updateCodeType :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)oldCodeType :(NSString *)codeID :(NSString *)newCodeType ;

//校验密码
-(void) verifyCode :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)password ;

//通知锁断开蓝牙连接
-(void) toDisconnBle :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno ;

//开关门
-(void) toUnlock :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)unlockType :(NSString *)code;

//清空非管理员用户、恢复出厂设置
-(void) cleanData :(NSString *) gatewayid :(NSString *)type :(NSString *)uuid :(NSString *)mac :(NSString *)sno :(NSString *)dataType ;

//通过mqtt 推送数据给其他用户
-(void) pushDataToOthers :(NSMutableDictionary *)dict ;
@end

NS_ASSUME_NONNULL_END
