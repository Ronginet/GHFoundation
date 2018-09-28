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

@end
