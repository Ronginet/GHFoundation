//
//  NSDictionary+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/10/15.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (NSDictionary *)jsonStringToDictionary:(NSString *)JSONString {
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

@end
