//
//  UIBarButtonItem+Extension.h
//  GHFoundation
//
//  Created by Rong on 2018/3/8.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)gh_barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)gh_barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;  // default is image size.
+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)hImage target:(id)target action:(SEL)action;

/// if size equal to CGSizeZero, set size with image size.
+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image imageSize:(CGSize)size target:(id)target action:(SEL)action;
+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)hImage imageSize:(CGSize)size target:(id)target action:(SEL)action;
+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)hImage disabledImage:(UIImage *)dImage imagesize:(CGSize)size target:(id)target action:(SEL)action;

- (void)gh_updateBarButtonTitleColor:(UIColor *)color;
- (void)gh_updateBarButtonImage:(UIImage *)image;
- (void)gh_setBarButtonItemEnable:(BOOL)enable;

- (__kindof UIButton *)gh_customButton;

@end
