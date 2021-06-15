//
//  mqttCallBack.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/4/28.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface mqttCallBack : NSObject {
    NSString *productKey;
    NSString *deviceName;
    NSString *deviceSecret;
    NSString *region;
}

+ (instancetype) sharedMqttCallBack;

//初始化mqtt
- (void) MqttInit :(NSString *)productKey :(NSString *)deviceName :(NSString *)deviceSecret :(NSString *)region;

//注销退出
-(void) logoutMQTT;


@end



NS_ASSUME_NONNULL_END
