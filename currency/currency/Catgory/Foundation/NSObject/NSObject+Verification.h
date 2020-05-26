//
//  NSObject+Verification.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/3/21.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Verification)

/**
 判断字符串是否为nil
 */
+ (BOOL)ldy_isEmpty:(id)obj;

/**
 返回非nil和NULL字符串
 */
+ (NSString *)ldy_returnNoEmpty:(id)obj;


/**
 返回非nil值/ 如果为空替换为默认值
 */
+ (NSString *)ldy_toString:(id)value defaultStr:(NSString *)defaultStr;

@end

NS_ASSUME_NONNULL_END
