//
//  NSDecimalNumber+Extension.m
//  GHFoundation
//
//  Created by Rong on 2019/6/11.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import "NSDecimalNumber+Extension.h"

@implementation NSDecimalNumber (Extension)

+ (NSDecimalNumber *)addWithValue1:(NSString *)value1 value2:(NSString *)value2 {
    if (!value1 || !value2) {
        return nil;
    }
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:value2];
    return [number1 decimalNumberByAdding:number2];
}

+ (NSDecimalNumber *)subtractWithValue1:(NSString *)value1 value2:(NSString *)value2 {
    if (!value1 || !value2) {
        return nil;
    }
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:value2];
    return [number1 decimalNumberBySubtracting:number2];
}

+ (NSDecimalNumber *)multiplyWithValue1:(NSString *)value1 value2:(NSString *)value2 {
    if (!value1 || !value2) {
        return nil;
    }
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:value2];
    return [number1 decimalNumberByMultiplyingBy:number2];
}

+ (NSDecimalNumber *)divideWithValue1:(NSString *)value1 value2:(NSString *)value2 {
    if (!value1 || !value2) {
        return nil;
    }
    
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:value2];
    return [number1 decimalNumberByDividingBy:number2];
}

- (NSDecimalNumber *)add:(NSString *)numberValue {
    if (!self || !numberValue) {
        return nil;
    }
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:numberValue];
    return [self decimalNumberByAdding:number];
}

- (NSDecimalNumber *)subtract:(NSString *)numberValue {
    if (!self || !numberValue) {
        return nil;
    }
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:numberValue];
    return [self decimalNumberBySubtracting:number];
}

- (NSDecimalNumber *)multiply:(NSString *)numberValue {
    if (!self || !numberValue) {
        return nil;
    }
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:numberValue];
    return [self decimalNumberByMultiplyingBy:number];
}

- (NSDecimalNumber *)divide:(NSString *)numberValue {
    if (!self || !numberValue) {
        return nil;
    }
    
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:numberValue];
    return [self decimalNumberByDividingBy:number];
}

@end
