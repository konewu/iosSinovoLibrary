//
//  SinovoBleCallBack.h
//  BTLock
//
//  Created by Rongkun Wu on 2021/5/3.
//  Copyright © 2021 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SinovoBleCallBack : NSObject {
    
}

+ (instancetype) sharedBleCallBack;

- (void) InitBle;

- (void) openOrClose;

@end

NS_ASSUME_NONNULL_END
