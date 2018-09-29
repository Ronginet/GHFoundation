//
//  NSString+Base64.h
//  GHFoundation
//
//  Created by Rong on 2018/5/11.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *)gh_encode:(NSString *)string;
+ (NSString *)gh_decode:(NSString *)base64String;

@end
