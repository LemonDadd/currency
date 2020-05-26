//
//  SearchLeftTextField.m
//  customer_rebuild
//
//  Created by quanqiuwa on 2019/4/23.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "SearchLeftTextField.h"

@implementation SearchLeftTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon_search"]];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.font = KFONTSIZE(12);
        self.tintColor = [UIColor colorWithHex:kMainColor];
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 0; //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 20, 0);
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 20, 0);
}

@end
