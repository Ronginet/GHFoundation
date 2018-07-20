//
//  GHDeviceInfo.m
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHDeviceInfo.h"

@implementation GHDeviceInfo

+ (NSString *)UUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

@end
