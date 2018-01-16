//
//  NSString+Extension.h
//  GHFoundation
//
//  Created by Rong on 2017/10/14.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

// 通用正则合法性判断
- (BOOL)isValidateWithRegex:(NSString *)regex;

// 判断是否为移动电话
- (BOOL)isMobileNumber;

// 判断是否为邮箱
- (BOOL)isEmail;

// 身份证号码验证
- (BOOL)isIdentityCard;

- (BOOL)isBlank;

- (BOOL)isNotBlank;

@end
