//
//  Singleton.h
//  GHFoundation
//
//  Created by Rong on 2018/2/9.
//  Copyright © 2018年 Rong. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h

// .h文件
#define SingletonH(methodName) + (instancetype)shared##methodName;


// .m文件
#if __has_feature(objc_arc)  // ARC

#define SingletonM(methodName) \
static id _instance = nil; \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone{ \
\
if (_instance == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
} \
return _instance; \
} \
\
-(instancetype)init{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super init]; \
}); \
return _instance; \
} \
\
+(id)copyWithZone:(struct _NSZone *)zone{ \
return _instance; \
} \
\
+(id)mutableCopyWithZone:(struct _NSZone *)zone{ \
return _instance; \
} \
+(instancetype)shared##methodName{ \
return [[self alloc]init]; \
}

#else  // MRC

#define SingletonM(methodName) \
static id _instance = nil; \
\
+(instancetype)allocWithZone:(struct _NSZone *)zone{ \
\
if (_instance == nil) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
} \
return _instance; \
} \
\
-(instancetype)init{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super init]; \
}); \
return _instance; \
} \
\
+(id)copyWithZone:(struct _NSZone *)zone{ \
return _instance; \
} \
\
+(id)mutableCopyWithZone:(struct _NSZone *)zone{ \
return _instance; \
} \
+(instancetype)shared##methodName{ \
return [[self alloc]init]; \
} \
\
-(oneway void)release{ \
\
} \
\
\
-(NSUInteger)retainCount{ \
return 1; \
} \
\
-(instancetype)retain{ \
return self; \
}

#endif

#endif /* Singleton_h */
