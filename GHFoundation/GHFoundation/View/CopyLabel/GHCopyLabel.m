//
//  GHCopyLabel.m
//  GHFoundation
//
//  Created by Rong on 2018/6/28.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHCopyLabel.h"

@implementation GHCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.copyEnable = YES;
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGR)]];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Private

- (void)longPressGR {
    if (!self.copyEnable) {
        return;
    }
    
    [self becomeFirstResponder];
    
    UIMenuController *menuVC = [UIMenuController sharedMenuController];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText)];
    menuVC.menuItems = @[item];
    [menuVC setTargetRect:self.bounds inView:self];
    [menuVC setMenuVisible:YES animated:YES];
}

- (void)copyText {
    if (!self.text) {
        return;
    }
    
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
}

@end
