//
//  UIDevice+Extension.h
//  GHFoundation
//
//  Created by Rong on 2018/1/24.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extension)

- (BOOL)gh_isiPhone;

- (BOOL)gh_isiPad;

- (CGFloat)gh_currentSystemVersion;

@end
