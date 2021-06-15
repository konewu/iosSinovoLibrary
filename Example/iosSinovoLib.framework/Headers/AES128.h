//
//  AES128.h
//  AES128
//
//  Created by kone on 2019/8/14.
//  Copyright © 2019 kone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128 : NSObject

//  AES28 Encrypt
//  Parameters:
//      plainText：text to be encrypted ，the length of text must be 32
//      lockMAC：MAC address of bluetooth lock，like ：8c85907b093b
+(NSString *)aes128_encrypt :(NSString *)plainText :(NSString *)lockMac;

//  AES28 Decrypt
//  Parameters:
//      cipherText：text to be decrypted ，the length of text must be 32
//      lockMAC：MAC address of bluetooth lock，like ：8c85907b093b
+(NSString *)aes128_decrypt :(NSString *)cipherText :(NSString *)lockMac;

@end
