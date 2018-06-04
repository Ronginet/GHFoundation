//
//  NSString+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/14.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)gh_isValidateWithRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)gh_isMobileNumber {
    // 移动: 134,135,136,137,138,139,150,151,157,158,159,187,188
    // 联通: 130,131,132,152,155,156,185,186
    // 电信: 133,153,180,189
    NSString *regex = @"^((13[0-9])|(15[^4\\D])|(18[0,2,3,5-9]|(17[0-9])))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)gh_isEmail {
    NSString *regex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)gh_isIdentityCard {
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

+ (BOOL)gh_isEmpty:(NSString *)string {
    if (!string || string.length == 0 || [string isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)gh_isNotEmpty:(NSString *)string {
    return ![self gh_isEmpty:string];
}

- (NSArray<NSValue *>*)gh_rangesOfText:(NSString *)text options:(NSStringCompareOptions)mask {
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

- (BOOL)gh_isChinese {
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (NSDictionary *)toDictionary {
    NSError *error;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return dict;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dict {
    if (!dict) {
        return nil;
    }
    if ([dict allKeys].count == 0) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)removeInvalidZeroWithFloat:(CGFloat)floatValue {
    NSString *floatString = [NSString stringWithFormat:@"%f",floatValue];
    const char *floatChar = [floatString UTF8String];
    NSUInteger length = 0;
    NSInteger i = floatString.length - 1;
    for(; i >= 0; i--) {
        if(floatChar[i] == '0') {
            length++;
        } else {
            if(floatChar[i] == '.')
                i--;
            break;
        }
    }
    
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [floatString substringToIndex:i+1];
    }
    return returnString;
}

@end
