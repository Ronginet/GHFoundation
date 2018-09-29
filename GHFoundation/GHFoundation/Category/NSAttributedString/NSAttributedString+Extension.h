//
//  NSAttributedString+Extension.h
//  GHFoundation
//
//  Created by Rong on 2018/9/29.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (Extension)

- (NSAttributedString *)gh_appendImage:(UIImage *)image;
- (NSAttributedString *)gh_appendImage:(UIImage *)image offset:(CGPoint)offset;

@end

@interface NSMutableAttributedString (Extension)

- (void)gh_appendImage:(UIImage *)image;
- (void)gh_appendImage:(UIImage *)image offset:(CGPoint)offset;

@end
