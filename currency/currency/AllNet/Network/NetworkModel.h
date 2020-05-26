//
//  NetworkModel.h
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/4/9.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkModel : NSObject
    
@property (nonatomic, strong) NSString * method;
@property (nonatomic, assign) int code;
@property (nonatomic, strong) NSString * message;
@property (nonatomic, strong) id returndata;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *serverTime;

- (instancetype)initWithParam:(NSDictionary *)param;
    
/**
 网络请求失败
*/
- (instancetype)initWithInterfaceError:(NSError *)error;
    
@end

NS_ASSUME_NONNULL_END
