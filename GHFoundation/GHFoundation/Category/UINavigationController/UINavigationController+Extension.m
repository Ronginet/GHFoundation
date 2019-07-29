//
//  UINavigationController+Extension.m
//  GHFoundation
//
//  Created by Rong on 2019/7/29.
//  Copyright © 2019 Rong. All rights reserved.
//

#import "UINavigationController+Extension.h"
#import "NSString+Extension.h"

@implementation UINavigationController (Extension)

- (void)gh_popToViewController:(NSString *)vcName animated:(BOOL)animated {
    if (self && [NSString gh_isNotEmpty:vcName]) {
        NSArray *vcs = self.viewControllers;
        NSArray *results = [vcs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(vcName)];
        }]];
        
        if (results.count > 0) {
            [self popToViewController:results.firstObject animated:animated];
        }
    }
}

@end
