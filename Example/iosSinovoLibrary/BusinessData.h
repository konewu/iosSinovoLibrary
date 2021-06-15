//
//  BusinessData.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/21.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BusinessData : NSObject

+ (instancetype) shared ;
- (void) onConnectLockViaQRCode :(NSMutableDictionary *)dict ;
- (void) onUnlock :(NSMutableDictionary *)dict ;
- (void) onCreateUser :(NSMutableDictionary *)dict ;
- (void) onUpdateUser :(NSMutableDictionary *)dict ;
- (void) onAddData :(NSMutableDictionary *)dict;
- (void) onDelData :(NSMutableDictionary *)dict ;
- (void) onVerifyCode :(NSMutableDictionary *)dict ;
- (void) onCleanData :(NSMutableDictionary *)dict ;
- (void) onLockInfo :(NSMutableDictionary *)dict ;
- (void) onRequestData :(NSMutableDictionary *)dict ;
- (void) onRequestLog :(NSMutableDictionary *)dict ;
- (void) onDynamicCodeStatus :(NSMutableDictionary *)dict ;
- (void) onLockFrozen :(NSMutableDictionary *)dict ;

@end

NS_ASSUME_NONNULL_END
