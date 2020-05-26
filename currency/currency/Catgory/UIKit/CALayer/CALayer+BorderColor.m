//
//  CALayer+BorderColor.m
//  DangerousGoodsPlatform
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 ysl. All rights reserved.
//

#import "CALayer+BorderColor.h"

@implementation CALayer (BorderColor)

- (void)setBoColor:(UIColor *)color

{
    self.borderColor = color.CGColor;
}


@end
