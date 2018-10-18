//
//  Foundation+Log.m
//  GHFoundation
//
//  Created by Rong on 2017/10/6.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    
    NSMutableString *tabM = [NSMutableString string];
    for (int i = 0; i < level; i++) {
        [tabM appendString:@"\t"];
    }
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [str appendFormat:@"\t%@%@ = %@,\n", tabM, key, [obj descriptionWithLocale:locale indent:level + 1]];
        } else {
            if ([obj isKindOfClass:[NSString class]]) {
                [str appendFormat:@"\t%@%@ = \"%@\",\n", tabM, key, obj];
            } else {
                [str appendFormat:@"\t%@%@ = %@,\n", tabM, key, obj];
            }
        }
    }];
    
    [str appendFormat:@"%@}", tabM];
    return str;
}

@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    
    NSMutableString *tabM = [NSMutableString string];
    for (int i = 0; i < level; i++) {
        [tabM appendString:@"\t"];
    }
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [str appendFormat:@"\t%@%@,\n", tabM, [obj descriptionWithLocale:locale indent:level + 1]];
        } else {
            if ([obj isKindOfClass:[NSString class]]) {
                [str appendFormat:@"\t%@\"%@\",\n", tabM, obj];
            } else {
                [str appendFormat:@"\t%@%@,\n", tabM, obj];
            }
        }
    }];
    
    [str appendFormat:@"%@]", tabM];
    return str;
}

@end
