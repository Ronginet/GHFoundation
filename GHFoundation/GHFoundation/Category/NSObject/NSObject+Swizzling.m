//
//  NSObject+Swizzling.m
//  GHFoundation
//
//  Created by Rong on 2019/1/2.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)methodSwizzlingWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 避免源SEL没有实现IMP的情况, 先尝试给源SEL添加IMP
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {  // 添加成功, 源SEL没有实现IMP, 将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {  // 源SEL已经有实现IMP, 直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
