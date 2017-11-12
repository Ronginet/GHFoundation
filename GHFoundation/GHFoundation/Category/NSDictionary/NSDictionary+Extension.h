//
//  NSDictionary+Extension.h
//  GHFoundation
//
//  Created by Rong on 2017/10/15.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

// json 字符串转字典
+ (NSDictionary *)parseJSONStringToDictionary:(NSString *)JSONString;
- (NSDictionary *)parseJSONStringToDictionary:(NSString *)JSONString;

@end