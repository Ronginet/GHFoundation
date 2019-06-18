//
//  NSObject+Extension.m
//  GHFoundation
//
//  Created by Rong on 2019/6/18.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

- (BOOL)checkIsExitPropertyWithClass:(Class)cls verifyPropertyName:(NSString *)verifyPropertyName {
    // 获取对象里的属性列表
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        // 属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    
    free(properties);
    return NO;
}

@end
