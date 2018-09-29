//
//  UIBarButtonItem+Extension.m
//  YouDianNiu
//
//  Created by Rong on 2018/3/8.
//  Copyright © 2018年 LanWoNiu. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)gh_barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : btn.titleLabel.font}];
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)gh_barButtonWithImage:(NSString *)imgName target:(id)target action:(SEL)action {
    UIImage *image = [UIImage imageNamed:imgName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 15, 15);
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

- (UIButton *)gh_customButton {
    UIButton *button = self.customView;
    if ([button isKindOfClass:[UIButton class]]) {
        return button;
    } else {
        return nil;
    }
}

@end
