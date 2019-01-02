//
//  NSObject+Swizzling.h
//  GHFoundation
//
//  Created by Rong on 2019/1/2.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
