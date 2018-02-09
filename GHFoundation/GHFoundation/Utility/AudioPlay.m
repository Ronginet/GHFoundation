//
//  AudioPlay.m
//  GHFoundation
//
//  Created by Rong on 2018/2/9.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "AudioPlay.h"
#import <AudioToolbox/AudioToolbox.h>

static NSMutableDictionary *_soundIds;

@implementation AudioPlay

+ (void)initialize {
    _soundIds = [NSMutableDictionary dictionary];
}

+ (void)playSoundWithURL:(NSURL *)soundURL shock:(BOOL)shock {
    SystemSoundID soundID = 0;
    soundID = [_soundIds[soundURL.absoluteString] unsignedIntValue];
    if (soundID == 0) {  // 不存在
        CFURLRef urlRef = (__bridge CFURLRef)(soundURL);
        // 创建SoundID
        AudioServicesCreateSystemSoundID(urlRef, &soundID);
        [_soundIds setObject:@(soundID) forKey:soundURL.absoluteString];
    }
    
    // 播放
    if (shock) {
        AudioServicesPlayAlertSound(soundID);  // 在真机上会震动
    } else {
        AudioServicesPlaySystemSound(soundID);  // 在真机上不会震动
    }
}

@end
