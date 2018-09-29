//
//  NSAttributedString+Extension.m
//  GHFoundation
//
//  Created by Rong on 2018/9/29.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

- (NSAttributedString *)gh_appendImage:(UIImage *)image {
    return [self gh_appendImage:image offset:CGPointZero];
}

- (NSAttributedString *)gh_appendImage:(UIImage *)image offset:(CGPoint)offset {
    NSMutableAttributedString *attrM = [self mutableCopy];
    [attrM gh_appendImage:image offset:offset];
    return attrM.copy;
}

@end

@implementation NSMutableAttributedString (Extension)

- (void)gh_appendImage:(UIImage *)image {
    return [self gh_appendImage:image offset:CGPointZero];
}

- (void)gh_appendImage:(UIImage *)image offset:(CGPoint)offset {
    NSTextAttachment *textAttachment = [NSTextAttachment new];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(2 + offset.x, -4 + offset.y, image.size.width, image.size.height);
    
    NSAttributedString *attr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [self appendAttributedString:attr];
}

@end
