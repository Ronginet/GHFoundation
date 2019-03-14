//
//  GHRecognizeLabel.m
//  GHFoundation
//
//  Created by Rong on 2019/3/14.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import "GHRecognizeLabel.h"
#import "NSAttributedString+Extension.h"
#import "UIView+Frame.h"

#define INT_TO_STRING(x) ([NSString stringWithFormat:@"%zd", x])
#define RECOGNIZE_TYPE_KEY (@"RECOGNIZE_TYPE_KEY")

typedef NS_ENUM(NSUInteger, GHRecognizeType) {
    GHRecognizeTypeNone = 0,
    GHRecognizeTypePhone,
    GHRecognizeTypeMail,
    GHRecognizeTypeURL,
};

@interface GHRecognizeResult : NSObject

@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, assign) GHRecognizeType recognizeType;
@property (nonatomic, assign) NSRange range;

@end

@implementation GHRecognizeResult

@end

#pragma mark -

@interface GHRecognizeLabel () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *blocks;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSLayoutManager *layoutManager;

@end

@implementation GHRecognizeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Public

- (void)recognizePhoneWithAttrs:(NSDictionary<NSFileAttributeKey,id> *)attrs tapBlock:(void (^)(NSString *))block {
    [self recognizeType:GHRecognizeTypePhone attributes:attrs tapBlock:block];
}

- (void)recognizeMailWithAttrs:(NSDictionary<NSFileAttributeKey,id> *)attrs tapBlock:(void (^)(NSString *))block {
    [self recognizeType:GHRecognizeTypeMail attributes:attrs tapBlock:block];
}

- (void)recognizeURLWithAttrs:(NSDictionary<NSFileAttributeKey,id> *)attrs tapBlock:(void (^)(NSString *))block {
    [self recognizeType:GHRecognizeTypeURL attributes:attrs tapBlock:block];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    if (_tapGR) {
        _tapGR.enabled = NO;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    if (_tapGR == nil) {
        self.tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        self.tapGR.delegate = self;
        [self addGestureRecognizer:self.tapGR];
    } else {
        _tapGR.enabled = YES;
    }
}

#pragma mark - Private

- (void)recognizeType:(GHRecognizeType)type attributes:(NSDictionary *)attrs tapBlock:(void(^)(NSString *))block {
    NSMutableAttributedString *attrStringM = [self.attributedText mutableCopy];
    NSMutableDictionary *dictM = [attrs mutableCopy];
    [dictM setObject:@(type) forKey:RECOGNIZE_TYPE_KEY];
    switch (type) {
        case GHRecognizeTypePhone: {
            [attrStringM recognizePhone:dictM];
        }
            break;
            
        case GHRecognizeTypeMail: {
            [attrStringM recognizeMail:dictM];
        }
            break;
            
        case GHRecognizeTypeURL: {
            [attrStringM recognizeURL:dictM];
        }
            break;
            
        default:
            break;
    }
    
    self.attributedText = attrStringM;
    if (block) {
        [self.blocks setObject:block forKey:INT_TO_STRING(type)];
    } else {
        [self.blocks removeObjectForKey:INT_TO_STRING(type)];
    }
}

- (NSDictionary *)attributesForGesture:(UIGestureRecognizer *)gesture range:(NSRangePointer)range {
    if (self.textStorage == nil) {
        self.textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
        [self.textStorage addLayoutManager:self.layoutManager];
    } else {
        [self.textStorage setAttributedString:self.attributedText];
    }
    
    CGSize size = [self sizeThatFits:self.size];
    CGPoint locationForTouchPoint = [gesture locationInView:self];
    if (!CGRectContainsPoint(CGRectMake(0, 0, size.width, size.height), locationForTouchPoint)) {
        return nil;
    }
    
    NSTextContainer *textContainer = self.layoutManager.textContainers.firstObject;
    textContainer.lineBreakMode = self.lineBreakMode;
    textContainer.maximumNumberOfLines = self.numberOfLines;
    textContainer.size = self.size;
    
    CGRect textRect = [self.layoutManager usedRectForTextContainer:textContainer];
    CGPoint textContainerOffset = CGPointMake((size.width - textRect.size.width) * 0.5 - textRect.origin.x, (size.height - textRect.size.height) * 0.5 - textRect.origin.y);
    CGPoint locationOfTouchInTextContainer = CGPointMake(locationForTouchPoint.x - textContainerOffset.x, locationForTouchPoint.y - textContainerOffset.y);
    NSInteger indexOfCharacter = [self.layoutManager characterIndexForPoint:locationOfTouchInTextContainer inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:nil];
    
    NSDictionary *attributes = [self.attributedText attributesAtIndex:indexOfCharacter effectiveRange:range];
    return attributes;
}

- (GHRecognizeResult *)recognizeTextForGesture:(UIGestureRecognizer *)gesture {
    NSRange range;
    NSDictionary *attributes = [self attributesForGesture:gesture range:&range];
    NSNumber *recognizeType = attributes[RECOGNIZE_TYPE_KEY];
    
    GHRecognizeResult *result = [GHRecognizeResult new];
    result.attributes = attributes;
    result.range = range;
    result.recognizeType = recognizeType.integerValue;
    return result;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        GHRecognizeResult *result = [self recognizeTextForGesture:tap];
        
        void(^block)(NSString *) = self.blocks[INT_TO_STRING(result.recognizeType)];
        if (block) {
            block([self.attributedText.string substringWithRange:result.range]);
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == self) {
        if (gestureRecognizer.view == self && [gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            GHRecognizeResult *result = [self recognizeTextForGesture:gestureRecognizer];
            return result.recognizeType != GHRecognizeTypeNone;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

#pragma mark - Getter,Setter

- (NSLayoutManager *)layoutManager {
    if (!_layoutManager) {
        _layoutManager = [[NSLayoutManager alloc] init];
        
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeZero];
        textContainer.lineFragmentPadding = 0.0;
        [_layoutManager addTextContainer:textContainer];
    }
    return _layoutManager;
}

@end
