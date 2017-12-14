//
//  UILabel+ZPKit.m
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import "UILabel+ZPKit.h"
#import "UIView+ZPKit.h"
#import "ZPUtils.h"

@implementation UILabel (ZPKit)
/**
 固定宽度计算文字高度
 
 @return <#return value description#>
 */
-(CGFloat)textHeight{
    return [ZPUtils textHeight:self.text font:self.font width:self.width];
}

/**
 固定高度计算文字宽度
 
 @return <#return value description#>
 */
-(CGFloat)textWidth{
    return [ZPUtils textWidth:self.text font:self.font height:self.height];
}
@end
