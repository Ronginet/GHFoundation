//
//  NSString+File.h
//  GHFoundation
//
//  Created by Rong on 2018/2/9.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)

/// 获取指定路径的文件/文件夹大小,单位: B
+ (NSInteger)gh_fileSizeWithPath:(NSString *)fullPath;
- (NSInteger)gh_fileSize;

@end
