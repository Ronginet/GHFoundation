//
//  NSDecimalNumber+Extension.h
//  GHFoundation
//
//  Created by Rong on 2019/6/11.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (Extension)

+ (NSDecimalNumber *)addWithValue1:(NSString *)value1 value2:(NSString *)value2;
+ (NSDecimalNumber *)subtractWithValue1:(NSString *)value1 value2:(NSString *)value2;
+ (NSDecimalNumber *)multiplyWithValue1:(NSString *)value1 value2:(NSString *)value2;
+ (NSDecimalNumber *)divideWithValue1:(NSString *)value1 value2:(NSString *)value2;

- (NSDecimalNumber *)add:(NSString *)numberValue;
- (NSDecimalNumber *)subtract:(NSString *)numberValue;
- (NSDecimalNumber *)multiply:(NSString *)numberValue;
- (NSDecimalNumber *)divide:(NSString *)numberValue;

@end
