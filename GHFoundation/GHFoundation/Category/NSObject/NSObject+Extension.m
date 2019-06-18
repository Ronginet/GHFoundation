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
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(cls, &count);  // 属性列表s
    
    for (i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    
    free(properties);
    return NO;
}

@end
