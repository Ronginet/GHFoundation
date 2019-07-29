//
//  UINavigationController+Extension.h
//  GHFoundation
//
//  Created by Rong on 2019/7/29.
//  Copyright © 2019 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Extension)

- (void)gh_popToViewController:(NSString *)vcName animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
