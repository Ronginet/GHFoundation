//
//  NSAttributedString+Extension.m
//  GHFoundation
//
//  Created by Rong on 2018/9/29.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "NSAttributedString+Extension.h"
#import "NSString+Extension.h"

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

- (void)recognizePhone:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    [self.string recognizeAllPhoneWithBlock:^(NSString *phone, NSRange range, BOOL *stop) {
        [self setAttributes:attrs range:range];
    }];
}

- (void)recognizeMail:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    [self.string recognizeAllMailWithBlock:^(NSString *mail, NSRange range, BOOL *stop) {
        [self setAttributes:attrs range:range];
    }];
}

- (void)recognizeURL:(NSDictionary<NSAttributedStringKey,id> *)attrs {
    [self.string recognizeAllURLWithBlock:^(NSString *url, NSRange range, BOOL *stop) {
        [self setAttributes:attrs range:range];
    }];
}

@end
