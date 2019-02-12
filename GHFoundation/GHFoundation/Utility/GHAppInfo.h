//
//  GHAppInfo.h
//  GHFoundation
//
//  Created by Rong on 2018/7/20.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHAppInfo : NSObject

/// 只包含bundle的version,不带"V",eg:1.0.0
+ (NSString *)appVersion;

+ (NSString *)appDisplayName;

+ (NSString *)appBuildVersion;

@end
