//
//  NSData+Image.h
//  GHFoundation
//
//  Created by Rong on 2018/1/24.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 图片类型
typedef NS_ENUM(NSUInteger, GHImageFormat) {
    GHImageFormatUndefined = -1,
    GHImageFormatPNG = 0,
    GHImageFormatJPEG = 1,
    GHImageFormatGIF = 2,
};

@interface NSData (Image)

/// 获取图片类型
- (GHImageFormat)gh_imageFormat;

@end

@interface NSString (ImageFormat)

/// 获取图片扩展名
+ (NSString *)gh_extensionForImageFormat:(GHImageFormat)imageFormat;

@end
