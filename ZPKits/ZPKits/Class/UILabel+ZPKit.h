//
//  UILabel+ZPKit.h
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZPKit)
/**
 固定宽度计算文字高度
 
 @return <#return value description#>
 */
-(CGFloat)textHeight;

/**
 固定高度计算文字宽度
 
 @return <#return value description#>
 */
-(CGFloat)textWidth;
@end
