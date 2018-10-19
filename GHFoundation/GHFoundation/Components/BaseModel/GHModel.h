//
//  GHModel.h
//  GHFoundation
//
//  Created by Rong on 2018/10/19.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHModel : NSObject

- (BOOL)ignorePropertyIfNoValue;  // 是否忽略没有值的属性, 默认YES
- (void)addIgnoreMapNames:(NSArray<NSString *> *)names;  // 映射成字典时, 忽略指定属性名
- (NSDictionary *)toDictionary;  // Model转字典

@end
