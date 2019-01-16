//
//  NSObject+SSProtectUnrecognizedCrash.m
//  TestRuntime
//
//  线上保护 unrecognizer selector 触发的crash
//
//  Created by Shane on 2018/12/28.
//  Copyright © 2018 Shane. All rights reserved.
//

#import "NSObject+SSProtectUnrecognizedCrash.h"
#import "NSObject+SSSwizing.h"
#import <objc/runtime.h>

#pragma mark - NEForwardingTargetObject

static const char *ne_types = "v@:";
static BOOL NEUnrecognizedSelGuardEnabled = NO;

@interface NEForwardingTargetObject : NSObject

@end

@implementation NEForwardingTargetObject

void dynamicMethodIMP(id self, SEL _cmd)
{
    // 可以使用 使用第三发库 PLCrashReporter 搜集调用堆栈信息。统一储存和上传。
}

+ (BOOL)resolveInstanceMethod:(SEL)aSel
{
    BOOL hasSel = [super resolveInstanceMethod:aSel];
    if (!hasSel) {
        hasSel = class_addMethod(self, aSel, (IMP)dynamicMethodIMP, ne_types);
    }
    return hasSel;
}

@end

#pragma mark - Unrecognized SEL Guard

@implementation NSObject (SSProtectUnrecognizedCrash)

+ (NEForwardingTargetObject *)ne_forwardingTargetObject
{
    static NEForwardingTargetObject *neForwardingTargetObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        neForwardingTargetObject = [[NEForwardingTargetObject alloc] init];
    });
    
    return neForwardingTargetObject;
}

- (id)ne_forwardingTargetForSelector:(SEL)aSelector
{
    //filter system selector forwarding
    if (NEUnrecognizedSelGuardEnabled &&
        ![NSStringFromClass([self class]) containsString:@"_"] &&
        ![self respondsToSelector:aSelector]) {
        
#ifdef DEBUG
        NSLog(@"unrecognized selector sent to instance [sel: %@, class: %@]", NSStringFromSelector(aSelector), NSStringFromClass([self class]));
#endif
        return [NSObject ne_forwardingTargetObject];
    }
    
    return [self ne_forwardingTargetForSelector:aSelector];
}

#pragma mark- setters and getters
+ (void)setUnrecognizedSELGuardEnabled:(BOOL)guardEnabled
{
    if (guardEnabled) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self ne_swizzleMethod:@selector(forwardingTargetForSelector:) withMethod:@selector(ne_forwardingTargetForSelector:) error:nil];
        });
    }
    
    NEUnrecognizedSelGuardEnabled = guardEnabled;
}

+ (BOOL)unrecognizedSELGuardEnabled {
    return NEUnrecognizedSelGuardEnabled;
}

@end
