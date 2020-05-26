//
//  NetworkModel.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/4/9.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NetworkModel.h"
#import "Tools.h"

@implementation NetworkModel
    
- (instancetype)initWithParam:(NSDictionary *)param
{
    self = [super init];
    if (self) {
        /* 临时 */
        if ([param isKindOfClass:[NSArray class]]) {
            self.code = 0;
            self.returndata = param;
            
            return self;
        }
        if (![NSObject ldy_isEmpty:param[@"code"]]) {
            
            self.code = [param[@"code"] intValue];
        }
        
        if (![NSObject ldy_isEmpty:param[@"message"]]) {
            self.message = param[@"message"];
        } else if (![NSObject ldy_isEmpty:param[@"msg"]]) {
            //兼容appversion
            self.message = param[@"msg"];
        }
        
        if (![NSObject ldy_isEmpty:param[@"data"]]) {
            self.returndata = param[@"data"];
        }
        
        if (![NSObject ldy_isEmpty:param[@"success"]]) {
            self.success = [param[@"success"] boolValue];
        }
        if (![NSObject ldy_isEmpty:param[@"serverTime"]]) {
            self.serverTime = param[@"serverTime"];
        }
    }
        
    return self;
}
    
- (instancetype)initWithInterfaceError:(NSError *)error
{
    self = [super init];
    if (self) {
        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"] ;
        NSString *errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary * errDic = [Tools dictionaryWithJsonString:errorStr];
        DLog(@"%@", errDic);
        
        self.code = -1;
        self.message = errDic[@"message"]?:@"网络错误~";
        self.success = false;
        self.returndata = [NSDictionary dictionary];
    }
    
    return self;
}
    
@end

