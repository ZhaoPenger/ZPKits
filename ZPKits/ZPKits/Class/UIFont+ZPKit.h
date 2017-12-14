//
//  UIFont+ZPKit.h
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ZPKit)
//便捷创建字体字体
#define ZPSystemFont(size) [UIFont systemFontOfSize:size]
//便捷创建系统粗字体
#define ZPBoldSystemFont(size) [UIFont boldSystemFontOfSize:size]
@end
