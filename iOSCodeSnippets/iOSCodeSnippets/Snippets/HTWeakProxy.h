//
//  HTWeakProxy.h
//  hellotalk
//
//  Created by DOLFVE on 2018/3/21.
//  Copyright © 2018年 Bigo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTWeakProxy : NSProxy

+ (instancetype)weakProxyWithTarget:(id)target;

@end
