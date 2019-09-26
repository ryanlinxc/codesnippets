//
//  HTWeakProxy.m
//  hellotalk
//
//  Created by DOLFVE on 2018/3/21.
//  Copyright © 2018年 Bigo. All rights reserved.
//

#import "HTWeakProxy.h"

@interface HTWeakProxy ()

@property (nonatomic, weak) id target;

@end

@implementation HTWeakProxy

+ (instancetype)weakProxyWithTarget:(id)target {
    HTWeakProxy *weakProxy = [HTWeakProxy alloc];
    weakProxy.target = target;
    
    return weakProxy;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = [invocation selector];
    id target = self.target; //使用强引用keep住弱引用对象，防止在后面调用方法的过程中释放掉
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    id target = self.target;
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    } else {
        // 返回nil会导致往HTWeakProxy发消息handleBadgeNotification:时发生crash: [NSProxy doesNotRecognizeSelector:handleBadgeNotification:]
        // 参考：https://github.com/facebookarchive/AsyncDisplayKit/blob/582bca93cbf173aaffee11b8b5e35c881d0bde9d/Source/Details/ASDelegateProxy.m
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
}


- (BOOL)respondsToSelector:(SEL)aSelector {
    return [self.target respondsToSelector:aSelector];
}

@end
