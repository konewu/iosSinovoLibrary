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
- (void) onMqttInitSuccess;
- (void) onMqttInitFailed;
- (void) onSubcribeSuccess;
- (void) onSubcribeFailed;
- (void) onPublishSuccess;
- (void) onPublishFailed;
- (void) onPublishTimeOut;

- (void) onLogoutSuccess;
- (void) onLogoutFailed;
- (void) onConnected;
- (void) onConnectionLost;
- (void) onMsgArrived :(NSString *)topic :(id) msg;

@end

@interface MqttInstance : NSObject {
    NSObject<MqttDelegate> *delegate;
    BOOL isMqttOK;
}

@property (strong, nonatomic) NSObject<MqttDelegate> *delegate;

+(instancetype) sharedMqtt;

-(void) MqttInit :(NSString *)productKey :(NSString *)deviceName :(NSString *)deviceSecret :(NSString *)region;
-(void) logoutMQTT;
-(void) unSubscriptTopic;

#pragma mark
/*
Disconnect the Bluetooth connection between the gateway and the lock
    gatewayid : the gateway's id , eg: 3C61052AD7FC
    macList   : NSMutableArray,  An array formed by the mac addresses of multiple locks
 */
-(void) disconnectLock :(NSString *)gatewayid :(NSMutableArray *)macList ;

/*
Add users to the lock via gateway
    gatewayid : the gateway's id , eg: 3C61052AD7FC
    mac: the bluetooth Mac address of the lock , eg: FC510BC5DD51
    sno: the SNO of the lock , eg: 906c4f
    userName: the username of the user to be added
 */
-(void) addUser :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)userName;

/*
 Modify the name of the lock user
    gatewayid : the gateway's id , eg: 3C61052AD7FC
    mac: the bluetooth Mac address of the lock , eg: FC510BC5DD51
    sno: the SNO of the lock , eg: 906c4f
    userName: the username of the user to be modified
    userNid: the nid of the user
 */
-(void)updateUserName :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)userName :(NSString *)userNid;

/*
 Add data for the user, such as: password, card, fingerprint
    userNid: the nid of the user
    dataType: 02 is code，03 is super code， 06 is card，07 is fingerprint， 08 is Alarm fingerprint
    password：Password to be added ； if datatype is 06、07、08，password should be set to @“”
 */
-(void) addDataForUser :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)userNid :(NSString *)dataType :(NSString *)password ;

/*
 delete data for the user, such as: password, card, fingerprint
    userNid: the nid of the user
    dataType: 02 is code，03 is super code， 06 is card，07 is fingerprint， 08 is Alarm fingerprint
    delID : the id of data
 */
-(void) delData :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)dataType :(NSString *)delID ;

/*
 Modify the password of the lock user
    userNid: the nid of the user
    codeType: 02 is code，03 is super code， 06 is card，07 is fingerprint， 08 is Alarm fingerprint
    codeID : the id of password
    newCode ：new password
 */
-(void) resetCode :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)userNid :(NSString *)codeType :(NSString *)codeID :(NSString *)newCode ;

/*
 Set the properties of the lock
 dataType ：setting type
   1 Set the lock name
   2 Set the lock time
   3 Set the autolock time
   4 set mute mode ，00 disable mute， 01 enable mute
   5 set auto create user after add lock via qrcode
   6 Set the permissions of the super user
       Share permissions： 01、03、05、07、09、11、13、15
       user manager permissions： 02、03、06、07、10、11、14、15
       setting lock permissions： 04、05、06、07、12、13、14、15
       check log permissions： 08、09、10、11、12、13、14、15
 */
-(void) setLockInfo :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(int)datatype :(NSString *)data ;

/*
 get information of the lock
     1 get the administrator information of the lock
     2 get the battery information of the lock
     3 get the status  of the lock
     4 get the firmware information of the lock
 */
-(void) getLockInfo :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(int)datatype;

//Synchronization lock user data
-(void) getAllUsers :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno;

//Synchronization lock log
-(void) getLog :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)logID ;

//Enable or disable dynamic password
//enable ：00 disable， 01 enable
-(void) doDynamicCode :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)dynamicCode :(NSString *)enable ;

//Modify password type
-(void) updateCodeType :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)oldCodeType :(NSString *)codeID :(NSString *)newCodeType ;

//verify password
-(void) verifyCode :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)password;

//Tell the lock to disconnect the Bluetooth connection
-(void) toDisconnBle :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno ;

//lock or unlock
-(void) toUnlock :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)unlockType :(NSString *)code;

//clean user
-(void) cleanData :(NSString *)gatewayid :(NSString *)mac :(NSString *)sno :(NSString *)dataType ;

//Clear user data, but do not include administrators
-(void) pushDataToOthers :(NSMutableDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
