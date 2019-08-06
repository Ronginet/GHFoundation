//
//  GHDeviceInfo.m
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHDeviceInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation GHWifiInfo

@end

@implementation GHDeviceInfo

+ (NSString *)UUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

+ (NSString *)currentWifiName {
    return [self currentWifi].SSID;
}

+ (GHWifiInfo *)currentWifi {
    GHWifiInfo *wifi = nil;
    CFArrayRef array = CNCopySupportedInterfaces();
    if (array) {
        CFDictionaryRef cfDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(array, 0));
        if (cfDict) {
            wifi = [GHWifiInfo new];
            NSDictionary *dict = CFBridgingRelease(cfDict);
            wifi.SSID = [dict valueForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            wifi.BSSID = [dict valueForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
        }
        CFRelease(array);
    }
    return wifi;
}

@end
