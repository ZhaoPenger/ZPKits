
//
//  UIButton+ZPKit.m
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import "UIButton+ZPKit.h"
#import "UIImage+ZPKit.h"
#import <objc/runtime.h>

@interface HandlerInvoke : NSObject <NSCopying>{}

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;
@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);

@end

@implementation HandlerInvoke

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents{
    self = [super init];
    if (self) {
        self.handler = handler;
        self.controlEvents = controlEvents;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    return [[HandlerInvoke alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender{
    self.handler(sender);
}

-(void)dealloc{
    
}

@end



static const void *ZPHandlersKey = &ZPHandlersKey;
@implementation UIButton (ZPKit)

/**
 设置Normal下的背景图片
 @param image 图片
 */
-(void)setNormalBackgroundImage:(UIImage*)image{
    [self setBackgroundImage:image forState:UIControlStateNormal];
}

/**
 设置hlighted]下的背景图片
 @param image 图片
 */
-(void)setHighlightedBackgroundImage:(UIImage*)image{
    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

/**
 设置Selected下的背景图片
 @param image 图片
 */
-(void)setSelectedBackgroundImage:(UIImage*)image{
    [self setBackgroundImage:image forState:UIControlStateSelected];
}

/**
 设置Normal下的背景图片
 @param name 图片名
 */
-(void)setNormalBackgroundImageName:(NSString*)name{
    [self setBackgroundImage:ZPNameImage(name) forState:UIControlStateNormal];
}

/**
 设置Highlighted下的背景图片
 @param name 图片名
 */
-(void)setHighlightedBackgroundImageName:(NSString*)name{
    [self setBackgroundImage:ZPNameImage(name) forState:UIControlStateHighlighted];
}

/**
 设置Selected下的背景图片
 @param name 图片名
 */
-(void)setSelectedBackgroundImageName:(NSString*)name{
    [self setBackgroundImage:ZPNameImage(name) forState:UIControlStateSelected];
}

/**
 设置Normal下的Title
 
 @param title <#title description#>
 */
-(void)setNormalTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateNormal];
}

/**
 设置Highlighted下的Title
 
 @param title <#title description#>
 */
-(void)setHighlightedTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateHighlighted];
}

/**
 设置Selected下的Title
 
 @param title <#title description#>
 */
-(void)setSelectedTitle:(NSString*)title{
    [self setTitle:title forState:UIControlStateSelected];
}

/**
 设置Normal下的Title Color
 
 @param color <#color description#>
 */
-(void)setNormalTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

/**
 设置Highlighted下的Title Color
 
 @param color <#color description#>
 */
-(void)setHighlightedTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateHighlighted];
}
/**
 创建便捷的通用点击事件
 
 @param controlEvent button事件
 @param handler 回调block
 */
-(void)handlerControlEvent:(UIControlEvents)controlEvent handler:(void (^)(id sender))handler{
    NSMutableArray *events = objc_getAssociatedObject(self, ZPHandlersKey);
    if (!events) {
        events = [NSMutableArray array];
        objc_setAssociatedObject(self, ZPHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    HandlerInvoke *target = [[HandlerInvoke alloc] initWithHandler:handler forControlEvents:controlEvent];
    [events addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvent];
}

/**
 创建最常用的TouchUpInside点击
 
 @param handler 回调block
 */
-(void)handlerTouchUpInsideEvent:(void (^)(id sender))handler{
    [self handlerControlEvent:UIControlEventTouchUpInside handler:handler];
}

/**
 移除target
 
 @param event <#event description#>
 */
-(void)removeTargetWithEvent:(UIControlEvents)event{
    NSMutableArray *events = objc_getAssociatedObject(self, ZPHandlersKey);
    NSMutableArray *copyArray = [events mutableCopy];
    [copyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HandlerInvoke *target = events[idx];
        if (target.controlEvents == event) {
            [self removeTarget:target action:NULL forControlEvents:event];
            [events removeObject:target];
        }
    }];
}

@end
