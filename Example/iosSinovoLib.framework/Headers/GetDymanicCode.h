//
//  GetDymanicCode.h
//  GetCode
//
//  Created by kone on 2019/5/22.
//  Copyright © 2019 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDymanicCode : NSObject


/*
 调用以下方法来生成动态密码
 参数：
 [onlytry getsomething:@"1893d734c579" :@"2019-04-08 18:19" :@"18:38" :@"03" :@"20:38"] ;
 1、锁端的蓝牙mac地址，格式 1893d734c579
 2、基准时间，格式 2019-04-08 18:19
 3、动态密码的起始时间，格式 2019-04-08 18:19 ； 如果此时为区间密码，则格式为 18:19
 4、密码的类型， 2为一次性密码，3位区间密码，4位限时密码
 5、密码的有效期，
 密码类型为限时密码时，
 1m 表示一个月,范围（1m-12m);
 1d 表示1天 ，取值范围(1d-31d)
 1h 表示1小时，取值范围（1h-24h）
 1M 表示10分钟，取值范围（1M-6M），M 表示10分钟
 
 密码类型为 一次性密码时，该值为固定的 3d
 
 密码类型为 区间密码时，该值为 区间密码的介绍时间，如 20:05
 */

//需要注意 ，新版的 动态密码 与老版本的 有差异，需要兼容
- (NSString *) getDymanicCode :(NSString *)mac_addr :(NSString*)baseTime :(NSString *)startTime :(NSString *)codeType :(NSString *)validTime;

@end
