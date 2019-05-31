//
//  NSObject+SEL.m
//  ZPKits
//
//  Created by 赵鹏 on 2019/5/31.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "NSObject+SEL.h"

@implementation NSObject (SEL)
-(id)performSelector:(SEL)aSelector withArguments:(NSArray*)arguments{

    if (aSelector == nil) return nil;
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;

    // invocation 有2个隐藏参数，所以 argument 从2开始
    if ([arguments isKindOfClass:[NSArray class]]){
        NSInteger count = MIN(arguments.count, signature.numberOfArguments - 2);
        for (int i = 0;i < count;i ++){
            const char *type = [signature getArgumentTypeAtIndex:2 + i];

            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            if (strcmp(type, "@") == 0){
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:2 + i];
            }
        }
    }

    [invocation invoke];

    id returnVal;
    if (strcmp(signature.methodReturnType, "@") == 0){
        [invocation getReturnValue:&returnVal];
    }
    return returnVal;

}

//Block
static id invokeBlock(id block ,NSArray *arguments) {
    if (block == nil) return nil;
    id target = [block  copy];

    const char *_Block_signature(void *);
    const char *signature = _Block_signature((__bridge void *)target);

    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:signature];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = target;

    // invocation 有1个隐藏参数，所以 argument 从1开始
    if ([arguments isKindOfClass:[NSArray class]]) {
        NSInteger count = MIN(arguments.count, methodSignature.numberOfArguments - 1);
        for (int i = 0; i < count; i++) {
            const char *type = [methodSignature getArgumentTypeAtIndex:1 + i];
            NSString *typeStr = [NSString stringWithUTF8String:type];
            if ([typeStr containsString:@"\""]) {
                type = [typeStr substringToIndex:1].UTF8String;
            }

            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            if (strcmp(type, "@") == 0) {
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:1 + i];
            }
        }
    }

    [invocation invoke];

    id returnVal;
    const char *type = methodSignature.methodReturnType;
    NSString *returnType = [NSString stringWithUTF8String:type];
    if ([returnType containsString:@"\""]) {
        type = [returnType substringToIndex:1].UTF8String;
    }
    if (strcmp(type, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    return returnVal;
}

@end
