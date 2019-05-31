//
//  NSObject+SEL.h
//  ZPKits
//
//  Created by 赵鹏 on 2019/5/31.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SEL)

-(id)performSelector:(SEL)aSelector withArguments:(NSArray*)arguments;

//Block
static id invokeBlock(id block ,NSArray *arguments);
@end

NS_ASSUME_NONNULL_END
