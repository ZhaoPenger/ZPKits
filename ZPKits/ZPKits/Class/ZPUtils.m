//
//  ZPUtils.m
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import "ZPUtils.h"
#import "ZPKit.h"
@implementation ZPUtils
/**
 计算文字宽度
 
 @param text <#text description#>
 @param font <#font description#>
 @param height <#height description#>
 @return <#return value description#>
 */
+(CGFloat)textWidth:(NSString*)text font:(UIFont*)font height:(CGFloat)height{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:
            NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:attribute
                              context:nil].size.width;
}


/**
 计算文字高度
 
 @param text <#text description#>
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
+(CGFloat)textHeight:(NSString*)text font:(UIFont*)font width:(CGFloat)width{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    return [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:
            NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:attribute
                              context:nil].size.height;
}

/**
 判断创建归档文件夹
 
 @return <#return value description#>
 */
+(NSString*)judgeCreateZPArchiveFolder{
    NSString *filePath = [DOCUMENT_PATH stringByAppendingString:@"/ZPArchive"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DLog(@"create ZPArchiveFolder failure. info:%@",error.userInfo);
        }
    }
    return filePath;
}

/**
 归档
 
 @param object <#object description#>
 @param name <#fileName description#>
 @return <#return value description#>
 */
+(BOOL)zp_archiveWithObject:(id)object fileName:(NSString*)name{
    NSString *filePath = [[ZPUtils judgeCreateZPArchiveFolder] stringByAppendingPathComponent:name];
    return [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}

/**
 解档
 
 @param name <#name description#>
 @return <#return value description#>
 */
+(id)zp_unArchiveWithFileName:(NSString*)name{
    NSString *filePath = [[ZPUtils judgeCreateZPArchiveFolder] stringByAppendingPathComponent:name];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

/**
 删除归档文件
 
 @param name <#name description#>
 @return <#return value description#>
 */
+(BOOL)zp_deleteArchiveWithFileName:(NSString*)name{
    NSString *filePath = [[ZPUtils judgeCreateZPArchiveFolder] stringByAppendingPathComponent:name];
    NSError *error;
    BOOL flag = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if (error) {
        DLog(@"delete ZPArchive file failure. info:%@",error.userInfo);
    }
    return flag;
}

@end
