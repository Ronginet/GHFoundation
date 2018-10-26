//
//  NSString+MD5.m
//  GHFoundation
//
//  Created by Rong on 2018/10/26.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MD5)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *stringM = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [stringM appendFormat:@"%02x", digest[i]];
    }
    return stringM.copy;
}

@end
