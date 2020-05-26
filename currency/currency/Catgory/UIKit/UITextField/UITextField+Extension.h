//
//  UITextField+Extension.h
//  customer_rebuild
//
//  Created by fen9fe1 on 2019/9/24.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extension)

- (void)placeholderColor:(UIColor *)color placeholder:(NSString *)placeholder;

- (void)placeholderFont:(UIFont *)font placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
