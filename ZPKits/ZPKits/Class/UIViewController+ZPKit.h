//
//  UIViewController+ZPKit.h
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    NavPositionLeft,
    NavPositionRgit,
} ZPNavPosition;

@interface UIViewController (ZPKit)
/**
 创建左右导航按钮
 
 @param position 位置
 @param title 标题
 @param iconName icon图片名
 */
-(void)creatNavButtonItemWithPosition:(ZPNavPosition)position title:(NSString*)title iconName:(NSString*)iconName;

/**
 左导航按钮
 
 @return <#return value description#>
 */
-(UIButton*)leftNavButton;


/**
 右导航按钮
 
 @return <#return value description#>
 */
-(UIButton*)rightNavButton;
@end
