//
//  NSData+ImageFormat.m
//  GHFoundation
//
//  Created by Rong on 2018/1/24.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSData+ImageFormat.h"

@implementation NSData (ImageFormat)

- (GHImageFormat)gh_imageFormat {
    uint8_t c;
    [self getBytes:&c length:1];
    switch (c) {
        case 0x89:
            return GHImageFormatPNG;
        case 0xFF:
            return GHImageFormatJPEG;
        case 0x47:
            return GHImageFormatGIF;
        default:
            return GHImageFormatUndefined;
    }
}

@end

@implementation NSString (ImageFormat)

+ (NSString *)gh_extensionForImageFormat:(GHImageFormat)imageFormat {
    switch (imageFormat) {
        case GHImageFormatPNG:
            return @"png";
        case GHImageFormatJPEG:
            return @"jpeg";
        case GHImageFormatGIF:
            return @"gif";
        default:
            return nil;
    }
}

@end
