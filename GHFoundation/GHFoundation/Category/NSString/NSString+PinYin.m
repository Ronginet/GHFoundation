//
//  NSString+PinYin.m
//  GHFoundation
//
//  Created by Rong on 2018/7/29.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSString+PinYin.h"

@implementation NSString (PinYin)

- (NSString *)pinyin {
    return [[self pinyinSpace] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)pinyinSpace {
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return str.copy;
}

@end
