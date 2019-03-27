//
//  UIViewController+Extension.m
//  GHFoundation
//
//  Created by Rong on 2018/9/28.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)gh_popToViewController:(NSString *)vcName animated:(BOOL)animated {
    if (self.navigationController) {
        NSArray *vcs = self.navigationController.viewControllers;
        NSArray *results = [vcs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(vcName)];
        }]];
        
        if (results.count > 0) {
            [self.navigationController popToViewController:results.firstObject animated:animated];
        }
    }
}

- (void)gh_setupTouchForDismissKeyboard {
    __weak UIViewController *weakSelf = self;
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    UITapGestureRecognizer *singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAnyWhereToDismissKeyboard:)];
    
    NSNotificationCenter *notifiCenter = [NSNotificationCenter defaultCenter];
    [notifiCenter addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.view addGestureRecognizer:singleTapGR];
    }];
    [notifiCenter addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf.view removeGestureRecognizer:singleTapGR];
    }];
}

- (void)tapAnyWhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    // self.view里所有的subview的first responder都被resign掉
    [self.view endEditing:YES];
}

@end
