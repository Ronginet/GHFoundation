//
//  NSString+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/14.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSString+Extension.h"

#define MobileNumberRegex (@"^((13[0-9])|(15[^4\\D])|(18[0,2,3,5-9]|(17[0-9])))\\d{8}$")
#define PhoneNumberRegex (@"\\+?\\d{1,4}?[-.\\s]?\\(?\\d{1,3}?\\)?[-.\\s]?\\d{1,4}[-.\\s]?\\d{1,4}[-.\\s]?\\d{3,9}")
#define MailRegex (@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
#define URLRegex (@"(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]")
#define IdentityCardRegex (@"^(\\d{14}|\\d{17})(\\d|[xX])$")
#define ChineseRegex (@"(^[\u4e00-\u9fa5]+$)")

@implementation NSString (Extension)

- (BOOL)gh_isValidateWithRegex:(NSString *)regex {
    return [self isMatchedByRegex:regex];
}

- (BOOL)gh_isMobileNumber {
    // 移动: 134,135,136,137,138,139,150,151,157,158,159,187,188
    // 联通: 130,131,132,152,155,156,185,186
    // 电信: 133,153,180,189
    return [self isMatchedByRegex:MobileNumberRegex];
}

- (BOOL)gh_isPhoneNumber {
    return [self isMatchedByRegex:PhoneNumberRegex];
}

- (BOOL)gh_isEmail {
    return [self isMatchedByRegex:MailRegex];
}

- (BOOL)gh_isURL {
    return [self isMatchedByRegex:URLRegex];
}

- (BOOL)gh_isIdentityCard {
    return [self isMatchedByRegex:IdentityCardRegex];
}

- (BOOL)gh_isChinese {
    return [self isMatchedByRegex:ChineseRegex];
}

- (BOOL)isMatchedByRegex:(NSString *)regex {
    if (self.length == 0) {
        return NO;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

+ (BOOL)gh_isEmpty:(NSString *)string {
    if (!string || [string isEqual:[NSNull null]] || string.length == 0 || [string isEqualToString:@"(null)"] || [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0) {
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

- (void)recognizeAllPhoneWithBlock:(void (^)(NSString *, NSRange, BOOL *))block {
    [self recognizeAllForRegex:PhoneNumberRegex withBlock:block];
}

- (void)recognizeAllMailWithBlock:(void (^)(NSString *, NSRange, BOOL *))block {
    [self recognizeAllForRegex:MailRegex withBlock:block];
}

- (void)recognizeAllURLWithBlock:(void (^)(NSString *, NSRange, BOOL *))block {
    [self recognizeAllForRegex:URLRegex withBlock:block];
}

- (void)recognizeAllForRegex:(NSString *)regex withBlock:(void (^)(NSString *, NSRange, BOOL *))block {
    NSError *error = nil;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex options:0 error:&error];
    if (!error) {
        [regular enumerateMatchesInString:self options:0 range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (block) {
                NSString *resultText = [self substringWithRange:result.range];
                block(resultText, result.range, stop);
            }
        }];
    }
}

- (NSDictionary *)gh_toDictionary {
    NSError *error;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return dict;
}

+ (NSString *)gh_jsonStringWithDictionary:(NSDictionary *)dict {
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

+ (NSString *)gh_removeInvalidZeroWithFloat:(CGFloat)floatValue {
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

+ (NSString *)gh_separatorBankCardNO:(NSString *)bankCardNO {
    NSString *tempText = [bankCardNO stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *returnText = @"";
    if(tempText.length >= 10){
        NSRange subRange = NSMakeRange(tempText.length - 4, 4);
        NSString *subString = [tempText substringWithRange:subRange];
        
        NSString *tmpStr = @"";
        for (int i = 0; i < 12; i++) {
            tmpStr = [tmpStr stringByAppendingString:@"*"];
        }
        returnText = [tmpStr stringByAppendingString:subString];
        
        NSInteger returnTextLength = returnText.length;
        NSString *formatStr = @"";
        NSString *subStr = @"";
        
        for (NSUInteger i = 0; i < returnTextLength; i += 4){
            if(i < returnTextLength - 5){
                NSRange range = NSMakeRange(i, 4);
                subStr = [returnText substringWithRange:range];
                formatStr = [formatStr stringByAppendingString:subStr];
                formatStr = [formatStr stringByAppendingString:@" "];
            } else {
                NSRange range = NSMakeRange(i, returnTextLength - i);
                subStr = [returnText substringWithRange:range];
                formatStr = [formatStr stringByAppendingString:subStr];
                returnText = formatStr;
                break;
            }
        }
    } else {
        returnText = tempText;
    }
    return returnText;
}

+ (NSString *)gh_stringFromNumber:(NSNumber *)number {
    NSNumberFormatter *format = [NSNumberFormatter new];
    format.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    format.numberStyle = NSNumberFormatterSpellOutStyle;
    return [format stringFromNumber:number];
}

@end
