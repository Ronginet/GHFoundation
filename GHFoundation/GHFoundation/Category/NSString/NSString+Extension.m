//
//  NSString+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/14.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)isValidateWithRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isMobileNumber {
    // 移动: 134,135,136,137,138,139,150,151,157,158,159,187,188
    // 联通: 130,131,132,152,155,156,185,186
    // 电信: 133,153,180,189
    NSString *regex = @"^((13[0-9])|(15[^4\\D])|(18[0,2,5-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *regex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isIdentityCard {
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isBlank {
    if (!self || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotBlank {
    return ![self isBlank];
}

- (NSArray<NSValue *>*)rangesOfText:(NSString *)text options:(NSStringCompareOptions)mask {
    if (!text && text.length == 0) {
        return @[];
    }
    
    NSMutableArray *arrM = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, self.length);
    while (searchRange.location + searchRange.length <= self.length) {
        NSRange range = [self rangeOfString:text options:mask range:searchRange];
        if (range.location == NSNotFound) {
            break;
        }
        
        NSUInteger location = range.location + range.length;
        searchRange = NSMakeRange(location, self.length - location);
        [arrM addObject:[NSValue valueWithRange:range]];
    }
    
    return arrM.copy;
}

@end
