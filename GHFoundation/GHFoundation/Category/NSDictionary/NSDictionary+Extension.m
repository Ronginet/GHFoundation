//
//  NSDictionary+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/15.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (NSDictionary *)parseJSONStringToDictionary:(NSString *)JSONString {
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return jsonDict;
}

- (NSDictionary *)parseJSONStringToDictionary:(NSString *)JSONString {
    return [NSDictionary parseJSONStringToDictionary:JSONString];
}

@end
