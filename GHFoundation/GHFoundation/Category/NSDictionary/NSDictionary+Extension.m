//
//  NSDictionary+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/15.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (NSDictionary *)dictionaryWithJSONString:(NSString *)JSONString {
    if (!JSONString) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        return nil;
    }
    return jsonDict;
}

- (NSString *)toJSONString {
    if ([self allKeys].count == 0) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
