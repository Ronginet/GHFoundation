//
//  UIBarButtonItem+Extension.h
//  YouDianNiu
//
//  Created by Rong on 2018/3/8.
//  Copyright © 2018年 LanWoNiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imgName target:(id)target action:(SEL)action;

@end
