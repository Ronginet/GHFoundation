//
//  NSObject+Extension.h
//  GHFoundation
//
//  Created by Rong on 2019/6/18.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/// 检测class是否存在某个属性
- (BOOL)checkIsExitPropertyWithClass:(Class)cls verifyPropertyName:(NSString *)verifyPropertyName;

@end
