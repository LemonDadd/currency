//
//  UIImageView+PlaceholderCache.m
//  customer_rebuild
//
//  Created by cy on 2020/2/25.
//  Copyright © 2020 TestProject. All rights reserved.
//

#import "UIImageView+PlaceholderCache.h"
#import <SDWebImage/SDWebImage.h>
#import <Masonry/Masonry.h>

@implementation UIImageView (PlaceholderCache)

- (void)sd_setImageWithStr:(nullable NSString *)url {
    //http://img1.quanqiuwa.com/M00/B2/42/wKgABV3bmZyAI9wTAAFH6H3wkTE358.png_1500x1500
    self.backgroundColor = KHEXCOLOR(0xeeeeee);
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.backgroundColor = [UIColor clearColor];
    }];
}

- (void)sd_setProductImageWithStr:(NSString *)url placeholderImage:(NSString *)placeholderStr {
    if (placeholderStr == nil) {
        placeholderStr = @"placeholder_guan";
    }
    self.contentMode = UIViewContentModeScaleAspectFit;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeholderStr]];
}

@end
