//
//  GHDeviceInfo.h
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHWifiInfo : NSObject

@property (nonatomic, copy) NSString *SSID;  // wifi name.
@property (nonatomic, copy) NSString *BSSID;

@end

@interface GHDeviceInfo : NSObject

+ (NSString *)UUID;

+ (NSString *)currentWifiName;

+ (GHWifiInfo *)currentWifi;

@end
