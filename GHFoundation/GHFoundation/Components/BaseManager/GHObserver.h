//
//  GHObserver.h
//  GHFoundation
//
//  Created by Rong on 2018/4/28.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHObserver : NSObject

// 观察者相关
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)postNotificationWithSelector:(SEL)selector withObject:(id)object;
- (void)postNotificationWithSelector:(SEL)selector withObjectOne:(id)objectOne objectTwo:(id)objectTwo;
- (void)postNotificationWithSelector:(SEL)selector withObjectOne:(id)objectOne objectTwo:(id)objectTwo objectThree:(id)objectThree;
- (void)postNotificationWithSelector:(SEL)selector
                      withObjectOne:(id)objectOne
                          objectTwo:(id)objectTwo
                        objectThree:(id)objectThree
                         objectFour:(id)objectFour;

// block 相关
- (void)addBlock:(id)block withKey:(NSString *)key;
- (NSMutableArray *)blocksWithKey:(NSString *)key;
- (void)clearBlocksForKey:(NSString *)key;
- (void)clearAllBlocks;

@end
