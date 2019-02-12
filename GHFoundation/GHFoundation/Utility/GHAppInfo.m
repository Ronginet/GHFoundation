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

+ (NSString *)appDisplayName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)appBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
