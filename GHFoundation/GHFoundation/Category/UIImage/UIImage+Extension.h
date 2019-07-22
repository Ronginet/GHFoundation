//
//  UIImage+Extension.h
//  GHFoundation
//
//  Created by Rong on 2017/11/12.
//  Copyright © 2017年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/// 颜色转图片
+ (UIImage *)gh_imageWithColor:(UIColor *)color;

/// 颜色转圆角图片
+ (UIImage *)gh_imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;

+ (UIImage *)gh_animatedGIFWithData:(NSData *)data;

+ (UIImage *)gh_stretchedImageWithName:(NSString *)name;

/// 圆形图片裁剪
+ (UIImage *)gh_imageClipWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/// 图片裁剪
- (UIImage *)gh_imageClipWithCornerRadius:(CGFloat)cornerRadius;

@end
