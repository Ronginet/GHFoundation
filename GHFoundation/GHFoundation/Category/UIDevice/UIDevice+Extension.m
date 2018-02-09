//
//  UIDevice+Extension.m
//  GHFoundation
//
//  Created by Rong on 2018/1/24.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)

- (BOOL)gh_isiPhone {
    if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
        return YES;
    }
    return NO;
}

- (BOOL)gh_isiPad {
    if ([[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
        return YES;
    }
    return NO;
}

- (CGFloat)gh_currentSystemVersion {
    return [UIDevice currentDevice].systemVersion.floatValue;
}

@end
