//
//  GHModel.m
//  GHFoundation
//
//  Created by Rong on 2018/10/19.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHModel.h"
#import <objc/runtime.h>

@interface GHModel ()

@property (nonatomic, strong) NSMutableArray<NSString *> *ignorePropertyNames;

@end

@implementation GHModel

- (NSString *)description {
    NSDictionary *dict = [self toDictionary];
    if (!dict || dict.count == 0) {
        return [super description];
    }
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"%@ {\n", [super description]];
    
    NSArray *keys = [dict allKeys];
    for (id key in keys) {
        NSString *propertyName = key;
        id value = [dict valueForKey:propertyName];
        if (!value && [self ignorePropertyIfNoValue]) {
            continue;
        }
        
        if ([value isKindOfClass:[NSString class]]) {
            [strM appendFormat:@"\t%@ = \"%@\",\n", propertyName, value];
        } else {
            [strM appendFormat:@"\t%@ = %@,\n", propertyName, value];
        }
    }
    [strM appendString:@"}"];
    
    return strM.copy;
}

#pragma mark - Public

- (BOOL)ignorePropertyIfNoValue {
    return YES;
}

- (void)addIgnoreMapNames:(NSArray<NSString *> *)names {
    if (![names isKindOfClass:[NSArray class]]) {
        return;
    }
    
    [self.ignorePropertyNames addObjectsFromArray:names];
}

- (NSDictionary *)toDictionary {
    unsigned int count = 0;
    Class cls = [self class];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    while (cls != [NSObject class]) {
        objc_property_t *propertys = class_copyPropertyList(cls, &count);
        
        for (int i = 0; i < count; i++) {
            objc_property_t property = propertys[i];
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            if ([propertyName isEqualToString:@"hash"] ||
                [propertyName isEqualToString:@"superclass"] ||
                [propertyName isEqualToString:@"description"] ||
                [propertyName isEqualToString:@"debugDescription"]) {
                continue;
            }
            
            if ([self.ignorePropertyNames containsObject:propertyName]) {
                continue;
            }
            
            id propertyValue = [self valueForKey:propertyName];
            
            if ([propertyValue isKindOfClass:[NSArray class]]) {
                NSMutableArray *arrM = [NSMutableArray array];
                for (id obj in propertyValue) {
                    id value;
                    if ([obj isKindOfClass:[GHModel class]]) {
                        value = [obj toDictionary];
                    } else {
                        value = obj;
                    }
                    
                    if (value) {
                        [arrM addObject:value];
                    }
                }
                propertyValue = arrM;
            } else if ([propertyValue isKindOfClass:[GHModel class]]) {
                id value = [propertyValue toDictionary];
                propertyValue = value;
            } else if ([propertyValue isKindOfClass:[NSDate class]]) {
                NSDate *date = (NSDate *)propertyValue;
                propertyValue = [NSNumber numberWithLongLong:[date timeIntervalSince1970] * 1000];
            }
            
            if (propertyValue) {
                [dictM addEntriesFromDictionary:@{propertyName : propertyValue}];
            }
        }
        
        if (propertys) {
            free(propertys);
        }
        
        cls = class_getSuperclass(cls);
    }
    return dictM.count ? dictM.copy : nil;
}

#pragma mark - Getter,Setter

- (NSMutableArray<NSString *> *)ignorePropertyNames {
    if (!_ignorePropertyNames) {
        _ignorePropertyNames = [NSMutableArray array];
    }
    return _ignorePropertyNames;
}

@end
