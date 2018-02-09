//
//  NSString+File.m
//  GHFoundation
//
//  Created by Rong on 2018/2/9.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

+ (NSInteger)gh_fileSizeWithPath:(NSString *)fullPath {
    return [fullPath gh_fileSize];
}

- (NSInteger)gh_fileSize {
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL dir = NO;
    // 两个作用:1.判断给定的路径存不存在  2.给定的路径是不是一个文件夹
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    if (!exists)  return -1;  // 文件/文件夹不存在
    
    if (!dir) {  // 文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
    
    // 遍历指定路径下里的所有子路径
    NSArray *subPaths = [mgr subpathsAtPath:self];
    NSInteger totalByteSize = 0;
    for (NSString *subPath in subPaths) {
        // 拼接全路径
        NSString *fullPath = [self stringByAppendingPathComponent:subPath];
        BOOL dir = NO;
        // 两个作用:1.判断给定的路径存不存在  2.给定的路径是不是一个文件夹
        [mgr fileExistsAtPath:fullPath isDirectory:&dir];
        if (dir == NO) {  // 文件
            NSDictionary *attrs = [mgr attributesOfItemAtPath:fullPath error:nil];
            totalByteSize += [attrs[NSFileSize] integerValue];
        }
    }
    return totalByteSize;
}

@end
