//
//  GHRecognizeLabel.h
//  GHFoundation
//
//  Created by Rong on 2019/3/14.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import "GHCopyLabel.h"

@interface GHRecognizeLabel : GHCopyLabel

- (void)recognizePhoneWithAttrs:(NSDictionary<NSFileAttributeKey, id> *)attrs tapBlock:(void(^)(NSString *phone))block;
- (void)recognizeMailWithAttrs:(NSDictionary<NSFileAttributeKey, id> *)attrs tapBlock:(void(^)(NSString *mail))block;
- (void)recognizeURLWithAttrs:(NSDictionary<NSFileAttributeKey, id> *)attrs tapBlock:(void(^)(NSString *url))block;

@end
