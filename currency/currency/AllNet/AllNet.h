//
//  AllNet.h
//  currency
//
//  Created by 关云秀 on 2020/5/27.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllNet : NSObject

+ (void)requestBriefWithPage:(NSInteger)page
                        request:(void(^)(NSArray *List,
                                         NSString *errorMsg))request;

@end

NS_ASSUME_NONNULL_END
