//
//  NSString+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/14.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)isMobileNumber {
    // 移动: 134,135,136,137,138,139,150,151,157,158,159,187,188
    // 联通: 130,131,132,152,155,156,185,186
    // 电信: 133,153,180,189
    NSString *regex = @"^((13[0-9])|(15[^4\\D])|(18[0,2,5-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matchs %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *regex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

@end
