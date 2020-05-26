//
//  UITextField+Extension.m
//  customer_rebuild
//
//  Created by fen9fe1 on 2019/9/24.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

- (void)placeholderColor:(UIColor *)color placeholder:(NSString *)placeholder
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:color}];
}

- (void)placeholderFont:(UIFont *)font placeholder:(NSString *)placeholder
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:font}];
}

@end
