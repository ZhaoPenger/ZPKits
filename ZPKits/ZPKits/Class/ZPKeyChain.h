//
//  ZPKeyChain.h
//  ZPKits
//
//  Created by 赵鹏 on 2017/12/14.
//  Copyright © 2017年 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPKeyChain : NSObject
/**
 <#Description#>
 
 @param key 保存东西到钥匙串
 @param data <#data description#>
 */
+ (void)saveWithKey:(NSString *)key data:(id)data;


/**
 加载钥匙串里的内容
 
 @param key <#key description#>
 @return <#return value description#>
 */
+ (id)loadWithKey:(NSString *)key;


/**
 删除钥匙串内容
 
 @param key <#key description#>
 */
+ (void)deleteWithKey:(NSString *)key;
@end
