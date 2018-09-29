//
//  NSDictionary+Extension.h
//  GHFoundation
//
//  Created by Rong on 2017/10/15.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/// json 字符串转字典
+ (NSDictionary *)gh_dictionaryWithJSONString:(NSString *)JSONString;

/// 字典转json字符串
- (NSString *)gh_toJSONString;

@end
