//
//  UIImageView+PlaceholderCache.h
//  customer_rebuild
//
//  Created by cy on 2020/2/25.
//  Copyright © 2020 TestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (PlaceholderCache)

- (void)sd_setImageWithStr:(nullable NSString *)url;

- (void)sd_setProductImageWithStr:(NSString *)url placeholderImage:(NSString *)placeholderStr;

@end

NS_ASSUME_NONNULL_END
