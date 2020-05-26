//
//  AllNet.m
//  currency
//
//  Created by 关云秀 on 2020/5/27.
//  Copyright © 2020 guanyunxiu. All rights reserved.
//

#import "AllNet.h"

#define pageSize @"30"

@implementation AllNet


+ (void)requestBriefWithPage:(NSInteger)page
request:(void(^)(NSArray *List,
                 NSString *errorMsg))request {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:pageSize forKey:@"size"];
    [params setObject:@"zh_CN" forKey:@"locale"];
    [[NetworkTool sharedHttpTool] GET:Brief params:params withBlock:^(NetworkModel * _Nonnull result) {
        
    }];
}

@end
