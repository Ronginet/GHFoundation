//
//  GHBaseManager.m
//  GHFoundation
//
//  Created by Rong on 2018/10/15.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHBaseManager.h"

static NSMutableDictionary *instances;
static NSLock *lock;
@implementation GHBaseManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instances = [NSMutableDictionary dictionary];
        lock = [NSLock new];
    });
    
    @synchronized (lock) {
        NSString *key = NSStringFromClass([self class]);
        id object = instances[key];
        if (object == nil) {
            object = [self new];
            [instances setObject:object forKey:key];
        }
        
        return object;
    }
}

@end
