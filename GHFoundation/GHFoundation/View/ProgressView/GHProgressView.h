//
//  GHProgressView.h
//  GHFoundation
//
//  Created by Rong on 2018/9/30.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GHProgressViewStyle) {
    GHProgressViewStyleDefault,
    GHProgressViewStyleTrackFillet ,  // 轨道圆角
    GHProgressViewStyleAllFillet,  //进度与轨道都圆角
};

@interface GHProgressView : UIView

- (instancetype)initWithFrame:(CGRect)frame progressViewStyle:(GHProgressViewStyle)style;

@property(nonatomic, assign) CGFloat progress;  // default 0.5, range 0.0 ... 1.0
@property(nonatomic, assign, readonly) GHProgressViewStyle progressViewStyle;
@property(nonatomic, assign) BOOL isTile;  // default NO, NO平铺填充, YES复制填充
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIImage *progressImage;  // 优先级大于背景色
@property(nonatomic, strong) UIImage *trackImage;

@end
