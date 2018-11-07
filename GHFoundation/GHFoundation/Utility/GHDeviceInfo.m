//
//  GHDeviceInfo.m
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHDeviceInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation GHDeviceInfo

+ (NSString *)UUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

+ (NSString *)currentWifiName {
    NSString *wifiName = nil;
    CFArrayRef array = CNCopySupportedInterfaces();
    if (array) {
        CFDictionaryRef cfDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array, 0));
        if (cfDict) {
            NSDictionary *dict = CFBridgingRelease(cfDict);
            wifiName = [dict valueForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
        }
    }
    return wifiName;
}

@end
