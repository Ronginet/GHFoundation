//
//  NSString+PinYin.h
//  GHFoundation
//
//  Created by Rong on 2018/7/29.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PinYin)

/// 每个汉字的拼音连在一起
- (NSString *)gh_pinyin;

/// 每个汉字的拼音间隔开
- (NSString *)gh_pinyinSpace;

@end
