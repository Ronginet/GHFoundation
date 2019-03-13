//
//  NSString+Extension.h
//  GHFoundation
//
//  Created by Rong on 2017/10/14.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/// 通用正则合法性判断
- (BOOL)gh_isValidateWithRegex:(NSString *)regex;

/// 判断是否为移动电话
- (BOOL)gh_isMobileNumber;
/// 判断是否为电话号码, 含固话
- (BOOL)gh_isPhoneNumber;

/// 判断是否为邮箱
- (BOOL)gh_isEmail;

/// 判断是否为URL
- (BOOL)gh_isURL;

/// 身份证号码验证
- (BOOL)gh_isIdentityCard;

/// 字符串是否为空
+ (BOOL)gh_isEmpty:(NSString *)string;

/// 字符串是否不为空
+ (BOOL)gh_isNotEmpty:(NSString *)string;

/// 获取子字符串在父字符串中出现的range
- (NSArray<NSValue *>*)gh_rangesOfText:(NSString *)text options:(NSStringCompareOptions)mask;

/// 电话, 邮箱和链接等识别
- (void)recognizeAllPhoneWithBlock:(void (^)(NSString *, NSRange, BOOL *))block;
- (void)recognizeAllMailWithBlock:(void (^)(NSString *, NSRange, BOOL *))block;
- (void)recognizeAllURLWithBlock:(void (^)(NSString *, NSRange, BOOL *))block;
- (void)recognizeAllForRegex:(NSString *)regex withBlock:(void (^)(NSString *, NSRange, BOOL *))block;

/// 是否纯中文
- (BOOL)gh_isChinese;

/// json字符串转字典
- (NSDictionary *)gh_toDictionary;

/// 字典转json字符串
+ (NSString *)gh_jsonStringWithDictionary:(NSDictionary *)dict;

/// 移除浮点数中无效的零
+ (NSString *)gh_removeInvalidZeroWithFloat:(CGFloat)floatValue;

/// 银行卡号显示格式化,显示后4位数字, 其他用*占位
+ (NSString *)gh_separatorBankCardNO:(NSString *)bankCardNO;

@end
