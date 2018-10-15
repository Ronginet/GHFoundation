//
//  GHBaseManager.h
//  GHFoundation
//
//  Created by Rong on 2018/10/15.
//  Copyright © 2018年 Rong. All rights reserved.
//

#import "GHObserver.h"

@interface GHBaseManager : GHObserver

+ (instancetype)sharedManager;

@end
