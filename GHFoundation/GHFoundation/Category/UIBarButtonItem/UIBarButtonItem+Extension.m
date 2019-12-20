//
//  UIBarButtonItem+Extension.m
//  GHFoundation
//
//  Created by Rong on 2018/3/8.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)gh_barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)gh_barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [self gh_barButtonItemWithImage:image imageSize:image.size target:target action:action];
}

+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image imageSize:(CGSize)size target:(id)target action:(SEL)action {
    return [self gh_barButtonItemWithImage:image highlightImage:image target:target action:action];
}

+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)hImage target:(id)target action:(SEL)action {
    return [self gh_barButtonItemWithImage:image highlightImage:hImage imageSize:image.size target:target action:action];
}

+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)hImage imageSize:(CGSize)size target:(id)target action:(SEL)action {
    return [self gh_barButtonItemWithImage:image highlightImage:hImage disabledImage:nil imagesize:size target:target action:action];
}

+ (instancetype)gh_barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)hImage disabledImage:(UIImage *)dImage imagesize:(CGSize)size target:(id)target action:(SEL)action {
    CGRect rect = CGRectZero;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        rect = CGRectMake(0, 0, image.size.width, image.size.height);
    } else {
        rect = CGRectMake(0, 0, size.width, size.height);
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:hImage forState:UIControlStateHighlighted];
    btn.frame = rect;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)gh_updateBarButtonTitleColor:(UIColor *)color {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void)gh_updateBarButtonImage:(UIImage *)image {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        [button setImage:image forState:UIControlStateNormal];
    }
}

- (void)gh_setBarButtonItemEnable:(BOOL)enable {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        button.enabled = enable;
    }
}

- (UIButton *)gh_customButton {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        return button;
    } else {
        return nil;
    }
}

@end
