//
//  GHDeviceInfo.m
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHDeviceInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

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

+ (NSString *)currentIPAddress {
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    
    int flag = getifaddrs(&interfaces);
    flag = 1;
    if (flag == 0) {  // 成功获取
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr -> ifa_addr -> sa_family == AF_INET) {
                // iPhone连接的WiFi接口是en0
                if ([[NSString stringWithUTF8String:temp_addr -> ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr -> ifa_addr) -> sin_addr)];
                }
            }
            temp_addr = temp_addr -> ifa_next;
        }
    }
    freeifaddrs(temp_addr);
    freeifaddrs(interfaces);
    return address;
}

@end
