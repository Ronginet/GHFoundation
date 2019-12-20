//
//  UIBarButtonItem+Extension.h
//  YouDianNiu
//
//  Created by Rong on 2018/3/8.
//  Copyright © 2018年 LanWoNiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)gh_barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)gh_barButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)gh_updateBarButtonTitleColor:(UIColor *)color;
- (void)gh_updateBarButtonImage:(UIImage *)image;

- (__kindof UIButton *)gh_customButton;

@end
