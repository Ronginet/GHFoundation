//
//  GHProgressView.m
//  GHFoundation
//
//  Created by Rong on 2018/9/30.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHProgressView.h"

@interface GHProgressView () {
    UIView *_progressView;
    CGFloat _progress;
}

@property(nonatomic, assign) GHProgressViewStyle progressViewStyle;

@end

@implementation GHProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame progressViewStyle:GHProgressViewStyleDefault];
}

- (instancetype)initWithFrame:(CGRect)frame progressViewStyle:(GHProgressViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        _progress = 0.5;
        self.progressViewStyle = style;
        [self addSubview:_progressView];
    }
    return self;
}

#pragma mark - Private

- (UIImage *)stretchableWithImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:self.bounds];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Getter, Setter

- (void)setProgressViewStyle:(GHProgressViewStyle)progressViewStyle {
    _progressViewStyle = progressViewStyle;
    
    if (progressViewStyle==GHProgressViewStyleTrackFillet) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.height / 2;
    } else if (progressViewStyle == GHProgressViewStyleAllFillet) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.bounds.size.height / 2;
        _progressView.layer.cornerRadius = self.bounds.size.height / 2;
    }
}

- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    
    if (self.trackImage) {
        
    } else {
        self.backgroundColor = trackTintColor;
    }
}

- (void)setProgress:(CGFloat)progress {
    _progress = MIN(progress, 1);
    _progressView.frame = CGRectMake(0, 0, self.bounds.size.width * _progress, self.bounds.size.height);
}

- (CGFloat)progress {
    return _progress;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    
    _progressView.backgroundColor = progressTintColor;
}

- (void)setTrackImage:(UIImage *)trackImage {
    _trackImage = trackImage;
    
    if (self.isTile) {
        self.backgroundColor = [UIColor colorWithPatternImage:trackImage];
    } else {
        self.backgroundColor = [UIColor colorWithPatternImage:[self stretchableWithImage:trackImage]];
    }
}

- (void)setIsTile:(BOOL)isTile {
    _isTile = isTile;
    
    if (self.progressImage) {
        [self setProgressImage:self.progressImage];
    }
    if (self.trackImage) {
        [self setTrackImage:self.trackImage];
    }
}

- (void)setProgressImage:(UIImage *)progressImage {
    _progressImage = progressImage;
    
    if(self.isTile) {
        _progressView.backgroundColor = [UIColor colorWithPatternImage:progressImage];
    } else {
        _progressView.backgroundColor = [UIColor colorWithPatternImage:[self stretchableWithImage:progressImage]];
    }
}

@end
