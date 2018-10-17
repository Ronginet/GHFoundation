//
//  UIBezierPath+Extension.m
//  GHFoundation
//
//  Created by Rong on 2018/10/17.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "UIBezierPath+Extension.h"
#import <objc/runtime.h>

static char lineColorKey;

@implementation UIBezierPath (Extension)

- (void)setLineColor:(UIColor *)lineColor {
    objc_setAssociatedObject(self, &lineColorKey, lineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)lineColor {
    return objc_getAssociatedObject(self, &lineColorKey);
}

@end
