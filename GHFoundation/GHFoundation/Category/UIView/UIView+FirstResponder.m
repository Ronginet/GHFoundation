//
//  UIView+FirstResponder.m
//  GHFoundation
//
//  Created by Rong on 2018/11/12.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "UIView+FirstResponder.h"

@implementation UIView (FirstResponder)

- (UIView *)findFirstResponder {
    if ([self isFirstResponder]) {
        return self;
    }
    
    for (UIView *view in self.subviews) {
        UIView *firstResponder = [view findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

@end
