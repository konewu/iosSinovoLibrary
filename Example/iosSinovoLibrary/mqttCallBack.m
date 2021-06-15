//
//  mqttCallBack.m
//  BTLock
//
//  Created by Rongkun Wu on 2021/4/28.
//  Copyright © 2021 kone. All rights reserved.
//

#import "mqttCallBack.h"
#import "IOAppDelegate.h"
#import "BusinessData.h"
#import "httpCallback.h"
#import <iosSinovoLib/iosSinovoLib.h>

@interface mqttCallBack ()<MqttDelegate>

@end
extern IOAppDelegate *myDelegate;
BOOL showLostTips = NO;
BOOL mqttLostAfterLogin = NO;   //mqtt 注册成功之后的 连接丢失记录

@implementation mqttCallBack

// 单例的实例化方法
+(instancetype) sharedMqttCallBack
{
    static id _instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });

    return _instance;
}


//MQTT initialize
-(void) MqttInit :(NSString *)productKey :(NSString *)deviceName :(NSString *)deviceSecret :(NSString *)region {
    [MqttInstance sharedMqtt].delegate = self;
    [[MqttInstance sharedMqtt] MqttInit :productKey :deviceName :deviceSecret :region ];
    
    //保存下 mqtt的注册参数
    self->productKey = productKey;
    self->deviceName = deviceName;
    self->deviceSecret = deviceSecret;
    self->region       = region;
}

//logout MQTT
-(void) logoutMQTT {
    [[MqttInstance sharedMqtt] logoutMQTT];
    NSLog(@"logoutMQTT");
}


//Mqtt connect success
- (void)onConnected { 
    NSLog(@"Mqtt onConnected ，Mqtt connect success,");
}

//MQTT Connection Lost
- (void)onConnectionLost {
    NSLog(@"Mqtt onConnectionLost");
   
}

//MQTT Logout failed
- (void)onLogoutFailed { 
    NSLog(@"Mqtt onLogoutFailed");
}

//MQTT Logout success
- (void)onLogoutSuccess {
    NSLog(@"Mqtt onLogoutSuccess");
}

//MQTT initialize Failed
- (void)onMqttInitFailed { 
    NSLog(@"MQTT initialize Failed");
}

//MQTT initialize success
- (void)onMqttInitSuccess {
    NSLog(@"MQTT initialize success");
}

//Receive message from MQTT server
- (void)onMsgArrived:(nonnull NSString *)topic :(nonnull id)msg { 
    NSLog(@"Receive message from MQTT server topic：%@ data:%@", topic, msg);
}

//Publish message to MQTT server failed
- (void)onPublishFailed { 
    NSLog(@"Publish message to MQTT server failed");
}

//Publish message to MQTT server timeout
- (void)onPublishTimeOut {
    NSLog(@"Publish message to MQTT server timeout");
}

//Publish message to MQTT server success
- (void)onPublishSuccess { 
    NSLog(@"Publish message to MQTT server success");
}


//Subcribe topic failed ；
//Data can be sent and received normally after subscribing to the topic
- (void)onSubcribeFailed {

    NSLog(@"ubcribe topic failed");
    
    //try to logout MQTT
    [[MqttInstance sharedMqtt] unSubscriptTopic];
    [[MqttInstance sharedMqtt] logoutMQTT];
    
    //try to initialize MQTT again
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf MqttInit :self->productKey :self->deviceName :self->deviceSecret :self->region];
    });
}

//Subcribe topic Success
- (void)onSubcribeSuccess {
    NSLog(@"Mqtt Subcribe topic Success");
    
    //do something
    
}


@end
