//
//  GHObserver.m
//  GHFoundation
//
//  Created by Rong on 2018/4/28.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHObserver.h"
#import <objc/message.h>

@interface GHObserver ()

@property (nonatomic, strong) NSHashTable *observers;
@property (nonatomic, strong) NSMutableDictionary *blocksDict;

@end

@implementation GHObserver

- (NSHashTable *)observers {
    if (_observers == nil) {
        _observers = [NSHashTable weakObjectsHashTable];
    }
    
    return _observers;
}

- (NSMutableDictionary *)blocksDict {
    if (_blocksDict == nil) {
        _blocksDict = [NSMutableDictionary dictionary];
    }
    
    return _blocksDict;
}

- (void)addObserver:(id)observer {
    @synchronized (self) {
        [self.observers addObject:observer];
    }
}

- (void)postNotificationWithSelector:(SEL)selector withObject:(id)object {
    [self postNotificationWithSelector:selector withObjectOne:object objectTwo:nil];
}

- (void)postNotificationWithSelector:(SEL)selector withObjectOne:(id)objectOne objectTwo:(id)objectTwo {
    [self postNotificationWithSelector:selector withObjectOne:objectOne objectTwo:objectTwo objectThree:nil];
}

- (void)postNotificationWithSelector:(SEL)selector withObjectOne:(id)objectOne objectTwo:(id)objectTwo objectThree:(id)objectThree {
    [self postNotificationWithSelector:selector withObjectOne:objectOne objectTwo:objectTwo objectThree:objectThree objectFour:nil];
}

- (void)postNotificationWithSelector:(SEL)selector
                      withObjectOne:(id)objectOne
                          objectTwo:(id)objectTwo
                        objectThree:(id)objectThree
                         objectFour:(id)objectFour {
    if (self.observers.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @synchronized (self) {
                for (id observer in self.observers) {
                    if([observer respondsToSelector:selector]) {
                        void (*callFuntion)(id, SEL, id, id, id, id) = (void(*)(id, SEL, id, id, id, id))objc_msgSend;
                        callFuntion(observer, selector, objectOne, objectTwo, objectThree, objectFour);
                    }
                }
            }
        });
    }
}

- (void)removeObserver:(id)observer {
    @synchronized (self) {
        [self.observers removeObject:observer];
    }
}

- (void)addBlock:(id)block withKey:(NSString *)key {
    if (block == nil) {
        return;
    }
    NSMutableArray *blocksInKey = self.blocksDict[key];
    if (blocksInKey == nil) {
        blocksInKey = [NSMutableArray arrayWithCapacity:3];
        [self.blocksDict setObject:blocksInKey forKey:key];
    }
    [blocksInKey addObject:block];
}

- (NSMutableArray *)blocksWithKey:(NSString *)key {
    return self.blocksDict[key];
}

- (void)clearBlocksForKey:(NSString *)key {
    [self.blocksDict[key] removeAllObjects];
}

- (void)clearAllBlocks {
    [self.blocksDict removeAllObjects];
}

@end
