//
//  GHAppInfo.m
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHAppInfo.h"

@implementation GHAppInfo

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end