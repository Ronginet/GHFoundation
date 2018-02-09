//
//  AudioPlay.h
//  GHFoundation
//
//  Created by Rong on 2018/2/9.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlay : NSObject

/// 播放短音效 shock:是否震动
+ (void)playSoundWithURL:(NSURL *)soundURL shock:(BOOL)shock;

@end
