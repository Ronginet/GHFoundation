//
//  UIImage+Extension.m
//  GHFoundation
//
//  Created by Rong on 2017/11/12.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import "UIImage+Extension.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Extension)

+ (UIImage *)gh_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gh_imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, cornerRadius * [UIScreen mainScreen].scale, cornerRadius * [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    [color setFill];
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gh_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    //获取数据源
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    // 获取图片数量(如果传入的是gif图的二进制，那么获取的是图片帧数)
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        NSTimeInterval duration = 0.0f;
        NSMutableArray *images = [NSMutableArray array];
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            duration += [self gh_frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        // 计算一次播放的总时间：每帧播放 1/30秒 * 图片总数
        if (!duration) {
            duration = (1.0f / 30.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    return animatedImage;
}

// 计算播放每一帧需要的时间
+ (float)gh_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    // 获取这一帧的属性字典
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    // 从字典中获取这一帧持续的时间
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    } else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);  // 释放内存
    return frameDuration;
}

+ (UIImage *)gh_stretchedImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)gh_imageClipWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    CGFloat imageW = image.size.width + 2 * borderWidth;
    CGFloat imageH = image.size.height + 2 * borderWidth;
    CGFloat circleWH = MIN(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleWH, circleWH), NO, [UIScreen mainScreen].scale);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleWH, circleWH)];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddPath(ctx, path.CGPath);
    if (borderWidth > 0.0) {
        [borderColor setStroke];
    }
    CGContextStrokePath(ctx);  // 渲染
    
    // 裁剪区域
    CGRect clipR = CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    [clipPath addClip];
    
    [image drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)gh_imageClipWithCornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [bezierPath addClip];
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
