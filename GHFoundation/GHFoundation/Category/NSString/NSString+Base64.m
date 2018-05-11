//
//  NSString+Base64.m
//  GHFoundation
//
//  Created by Rong on 2018/5/11.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSString+Base64.h"
#import "NSString+Extension.h"

@implementation NSString (Base64)

+ (NSString *)encode:(NSString *)string {
    if ([NSString gh_isEmpty:string]) {
        return nil;
    }
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *base64String = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString *)decode:(NSString *)base64String {
    if ([NSString gh_isEmpty:base64String]) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

@end
