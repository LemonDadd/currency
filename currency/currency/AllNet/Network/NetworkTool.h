//
//  NetworkTool.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/4/9.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "NetworkModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface NetworkTool : NSObject

+ (instancetype)sharedHttpTool;
    
- (void)GET:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block;
- (void)GET:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block;

- (void)POST:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block;
- (void)POST:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block;
- (void)POST:(NSString *)url params:(id)params needCustomize:(BOOL)needCustomize withBlock:(void (^)(NetworkModel * result))block;

- (void)DELETE:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block;
- (void)DELETE:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block;
- (void)DELETE:(NSString *)url params:(id)params needCustomize:(BOOL)needCustomize withBlock:(void (^)(NetworkModel * result))block;

- (void)PUT:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block;
- (void)PUT:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block;

- (void)uploadMutableImageByUrlString:(NSString *)urlString
                               params:(NSDictionary *)params
                               images:(NSArray*)images
                              process:(void(^)(CGFloat process))process
                              request:(nonnull void (^)(NetworkModel * _Nonnull))block;


- (void)deleteMutableImageByImageUrlString:(NSString *)urlString
                              request:(nonnull void (^)(NetworkModel * _Nonnull))block;

@end

NS_ASSUME_NONNULL_END
