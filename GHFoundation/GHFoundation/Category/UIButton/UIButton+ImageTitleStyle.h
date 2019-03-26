//
//  UIButton+ImageTitleStyle.h
//  GHFoundation
//
//  Created by Rong on 2019/3/25.
//  Copyright © 2019年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图片和文字的位置关系
typedef NS_ENUM(NSInteger, GHButtonImageTitleStyle ) {
    GHButtonImageTitleStyleLeft = 0,  //图片在左，文字在右，整体居中。
    GHButtonImageTitleStyleRight = 2,  //图片在右，文字在左，整体居中。
    GHButtonImageTitleStyleTop = 3,  //图片在上，文字在下，整体居中。
    GHButtonImageTitleStyleBottom = 4,  //图片在下，文字在上，整体居中。
    GHButtonImageTitleStyleCenterTop = 5,  //图片居中，文字在上距离按钮顶部。
    GHButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    GHButtonImageTitleStyleCenterUp = 7,  //图片居中，文字在图片上面。
    GHButtonImageTitleStyleCenterDown = 8,  //图片居中，文字在图片下面。
    GHButtonImageTitleStyleRightLeft = 9,  //图片在右，文字在左，距离按钮两边边距
    GHButtonImageTitleStyleLeftRight = 10,  //图片在左，文字在右，距离按钮两边边距
    
    GHButtonImageTitleStyleDefault = GHButtonImageTitleStyleLeft,
};

@interface UIButton (ImageTitleStyle)

/// 调整按钮的文本和image的布局，padding为title和image的间隔。(title和image需同时存在, 需在按钮布局完以后调用)
- (void)gh_updateButtonImageTitleStyle:(GHButtonImageTitleStyle)style padding:(CGFloat)padding;

@end
