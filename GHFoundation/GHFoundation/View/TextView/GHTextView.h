//
//  GHTextView.h
//  GHFoundation
//
//  Created by Rong on 2018/5/11.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;  // Default is nil;
@property (nonatomic, strong) UIColor *placeholderColor;  // Default is [UIColor lightGrayColor]

@end
