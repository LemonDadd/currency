//
//  NetworkTool.m
//  customer_rebuild
//
//  Created by 全球蛙 on 2019/4/9.
//  Copyright © 2019 TestProject. All rights reserved.
//

#import "NetworkTool.h"
#import <YYModel/YYModel.h>
@interface NetworkTool ()
    
@property (nonatomic, strong) NSMutableArray * requestArray;
    
@end

static AFHTTPSessionManager * _mgr;
static UIDevice *_device;

@implementation NetworkTool

+ (instancetype)sharedHttpTool
{
    static id instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        _mgr = [AFHTTPSessionManager manager];
        _mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        [_mgr.requestSerializer setTimeoutInterval:20.0];
        _mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"application/x-www-form-urlencoded", @"text/plain", nil];
        [_mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        _mgr.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        _mgr.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _device =  [[UIDevice alloc] init];
    });
    
    return instance;
}

- (void)GET:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    NSMutableString * URLString = [NSMutableString stringWithFormat:@"%@", url];
    for (int i = 0; i < titleBody.count; i ++) {
        [URLString appendFormat:@"/%@", titleBody[i]];
    }
    [self GET:URLString params:params withBlock:block];
}
    
- (void)GET:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    KWeakSelf;
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    AFHTTPSessionManager * manager = [self addToken];
     NSString * URLString = @"";
    if ([url hasPrefix:@"http"]||[url hasPrefix:@"https"]) {
        URLString = url;
    } else {
        URLString = [NSString stringWithFormat:@"%@%@", [self getApiUrl], url];
    }
    [self logURLString:URLString param:params request:@"GET" manager:manager];
    [manager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        NSString *time = [NSString stringWithFormat:@"%f ms",linkTime*1000.0];
        [self logURLString:URLString param:params request:@"GET" manager:manager date:time];
        block([[NetworkModel alloc] initWithParam:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        NetworkModel *model =  [[NetworkModel alloc] initWithInterfaceError:error];
        block([[NetworkModel alloc] initWithInterfaceError:error]);
    }];
}

- (void)POST:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    NSMutableString * URLString = [NSMutableString stringWithFormat:@"%@", url];
    for (int i = 0; i < titleBody.count; i ++) {
        [URLString appendFormat:@"/%@", titleBody[i]];
    }
    [self POST:URLString params:params withBlock:block];
}

- (void)POST:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    [self POST:url params:params needCustomize:NO withBlock:block];
}

- (void)POST:(NSString *)url params:(id)params needCustomize:(BOOL)needCustomize withBlock:(void (^)(NetworkModel * result))block
{
//    for (NSString * request in self.requestArray) {
//        if ([url isEqualToString:request]) {
//            NSLog(@"取消了一个重复的请求:%@",url);
//            return;
//        }
//    }
//    [_requestArray addObject:url];
    //KWeakSelf;
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    AFHTTPSessionManager * manager = [self addToken];

    NSString * URLString = [NSString stringWithFormat:@"%@%@", [self getApiUrl], url];
    if (needCustomize) {
        [self customizeRequestBody];
    }
    [self logURLString:URLString param:params request:@"POST" manager:manager];
    [manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //[weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        NSString *time = [NSString stringWithFormat:@"%f ms",linkTime*1000.0];
        [self logURLString:URLString param:params request:@"POST" manager:manager date:time];
        block([[NetworkModel alloc] initWithParam:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //[weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        NetworkModel *model =  [[NetworkModel alloc] initWithInterfaceError:error];
            block([[NetworkModel alloc] initWithInterfaceError:error]);
    }];
}

- (void)DELETE:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    NSMutableString * URLString = [NSMutableString stringWithFormat:@"%@", url];
    for (int i = 0; i < titleBody.count; i ++) {
        [URLString appendFormat:@"/%@", titleBody[i]];
    }
    [self DELETE:URLString params:params withBlock:block];
}

- (void)DELETE:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    [self DELETE:url params:params needCustomize:NO withBlock:block];
}

- (void)DELETE:(NSString *)url params:(id)params needCustomize:(BOOL)needCustomize withBlock:(void (^)(NetworkModel * result))block
{
    for (NSString * request in self.requestArray) {
        if ([url isEqualToString:request]) {
            NSLog(@"取消了一个重复的请求:%@",url);
            return;
        }
    }
    [_requestArray addObject:url];
    KWeakSelf;
     CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    AFHTTPSessionManager * manager = [self addToken];
    [manager.requestSerializer setValue:@"DELETE" forHTTPHeaderField:@"X-HTTP-Method-Override"];

    NSString * URLString = [NSString stringWithFormat:@"%@%@", [self getApiUrl], url];
    if (needCustomize) {
        [self customizeRequestBody];
    }
    [self logURLString:URLString param:params request:@"DELETE" manager:manager];
    [manager.requestSerializer setValue:@"DELETE" forHTTPHeaderField:@"X-HTTP-Method-Override"];
//    [manager DELETE:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
//        block([[NetworkModel alloc] initWithParam:responseObject]);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
//        block([[NetworkModel alloc] initWithInterfaceError:error]);
//    }];
    [manager POST:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        NSString *time = [NSString stringWithFormat:@"%f ms",linkTime*1000.0];
        [self logURLString:URLString param:params request:@"GET" manager:manager date:time];
        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        block([[NetworkModel alloc] initWithParam:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        block([[NetworkModel alloc] initWithInterfaceError:error]);
    }];
}

- (void)PUT:(NSString *)url titleBody:(NSArray *)titleBody params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    NSMutableString * URLString = [NSMutableString stringWithFormat:@"%@", url];
    for (int i = 0; i < titleBody.count; i ++) {
        [URLString appendFormat:@"/%@", titleBody[i]];
    }
    [self PUT:URLString params:params withBlock:block];
}

- (void)PUT:(NSString *)url params:(id)params withBlock:(void (^)(NetworkModel * result))block
{
    for (NSString * request in self.requestArray) {
        if ([url isEqualToString:request]) {
            NSLog(@"取消了一个重复的请求:%@",url);
            return;
        }
    }
    [_requestArray addObject:url];
    KWeakSelf;
     CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    AFHTTPSessionManager * manager = [self addToken];
    NSString * URLString = [NSString stringWithFormat:@"%@%@", [self getApiUrl], url];
    [self logURLString:URLString param:params request:@"PUT" manager:manager];
    [manager PUT:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        NSString *time = [NSString stringWithFormat:@"%f ms",linkTime*1000.0];
        [self logURLString:URLString param:params request:@"GET" manager:manager date:time];
        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        block([[NetworkModel alloc] initWithParam:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.requestArray removeObject:url]; //从请求队里里面移除
        block([[NetworkModel alloc] initWithInterfaceError:error]);
    }];
}

- (void)uploadMutableImageByUrlString:(NSString *)urlString
                               params:(NSDictionary *)params
                               images:(NSArray*)images
                              process:(void(^)(CGFloat process))process
                              request:(nonnull void (^)(NetworkModel * _Nonnull))block{
    if (images.count > 0) {
        for (NSString * request in self.requestArray) {
            if ([urlString isEqualToString:request]) {
                NSLog(@"取消了一个重复的请求:%@",urlString);
                return;
            }
        }
        [_requestArray addObject:urlString];
        KWeakSelf;
         CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
        AFHTTPSessionManager *manager = _mgr;
        NSString * URLString = [NSString stringWithFormat:@"%@%@", [self getApiUrl], urlString];
        [manager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i = 0;  i < images.count; i++) {
                
                id image =images[i];
                
                if ([image isKindOfClass:[UIImage class]]) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"yyyyMMddHHmmss";
                    NSString *str = [formatter stringFromDate:[NSDate date]];
                    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                    UIImage *imageObj = images[i];
                    NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
                    [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
                }
                
                if ([image isKindOfClass:[NSArray class]]) {
                    NSArray *list = [NSArray arrayWithArray:image];
                    for (UIImage *obj in list) {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmss";
                        NSString *str = [formatter stringFromDate:[NSDate date]];
                        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                        UIImage *imageObj = obj;
                        NSData *imageData = UIImageJPEGRepresentation(imageObj, 0.5);
                        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
                    }
                }
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            if (process != nil) {
                if (images.count > 1) {
                    process(1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
                } else {
                    NSInteger fractionCompleted = uploadProgress.fractionCompleted * 100;
                    CGFloat number = fractionCompleted/100.f;
                    process(number);
                }
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
            NSString *time = [NSString stringWithFormat:@"%f ms",linkTime*1000.0];
            [self logURLString:URLString param:params request:@"GET" manager:manager date:time];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUDManager hideHUD];
            });
            [weakSelf.requestArray removeObject:urlString]; //从请求队里里面移除
             block([[NetworkModel alloc] initWithParam:responseObject]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUDManager hideHUD];
            });
            [weakSelf.requestArray removeObject:urlString]; //从请求队里里面移除
            block([[NetworkModel alloc] initWithInterfaceError:error]);
        }];
    }
}

- (void)deleteMutableImageByImageUrlString:(NSString *)urlString
                                   request:(nonnull void (^)(NetworkModel * _Nonnull))block {
    
}


/**
 自定义请求体
 */
- (void)customizeRequestBody
{
    AFHTTPSessionManager * manager = _mgr;
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        NSArray * array = [parameters allKeys];
        NSMutableString * jsonStr = [NSMutableString string];
        if (array.count == 0) {
            return jsonStr;
        }
        for (NSString * key in array) {
            [jsonStr appendFormat:@"%@=", key];
            id value = [parameters objectForKey:key];
            if ([value isKindOfClass:[NSArray class]]) {
                NSData * data = [NSJSONSerialization dataWithJSONObject:value options:0 error:nil];
                NSString * arrayStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSString * str1 = [[[arrayStr stringByReplacingOccurrencesOfString:@"\"" withString:@""] stringByReplacingOccurrencesOfString:@"[" withString:@""] stringByReplacingOccurrencesOfString:@"]" withString:@""];
                [jsonStr appendFormat:@"%@,", str1];
            } else {
                [jsonStr appendFormat:@"%@,", value];
            }
        }
        
        NSRange range = NSMakeRange(jsonStr.length - 1, 1);
        [jsonStr deleteCharactersInRange:range];
        
        [_mgr.requestSerializer setQueryStringSerializationWithBlock:nil];
        
        return jsonStr;
    }];
}

- (AFHTTPSessionManager *)addToken
{
    AFHTTPSessionManager * manager = _mgr;
    [manager.requestSerializer setValue:AppKey forHTTPHeaderField:@"X-API-KEY"];
    return manager;
}

/**
 打印请求链接
 */
- (void)logURLString:(NSString *)URLString param:(NSDictionary *)param request:(NSString *)request manager:(AFHTTPSessionManager *)manager date:(NSString *)date
{
    NSDictionary * header = manager.requestSerializer.HTTPRequestHeaders;
    if (![param isKindOfClass:[NSDictionary class]]) {
        DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@\n请求参数:%@\n耗时:%@", header, request, URLString, param,date);
        return;
    }
    
    NSArray * allKeys = param.allKeys;
    if (allKeys.count == 0) {
        DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@\n耗时:%@", header, request, URLString,date);
    } else {
        NSArray * allValues = param.allValues;
        NSMutableString * paramStr = [NSMutableString string];
        if ([request isEqualToString:@"GET"]) {
            for (int i = 0; i < allKeys.count; i ++) {
                if (i != 0) {
                    [paramStr appendFormat:@"&"];
                }
                [paramStr appendFormat:@"%@=%@", allKeys[i], allValues[i]];
            }
            DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@?%@\n耗时:%@", header, request, URLString, paramStr,date);
        } else {
            paramStr = [self dictionarytToJsonData:param];
            DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@\n请求参数:\n%@\n耗时:%@", header, request, URLString, paramStr,date);
        }
    }
}

- (void)logURLString:(NSString *)URLString param:(NSDictionary *)param request:(NSString *)request manager:(AFHTTPSessionManager *)manager
{
    NSDictionary * header = manager.requestSerializer.HTTPRequestHeaders;
    if (![param isKindOfClass:[NSDictionary class]]) {
        DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@\n请求参数:%@", header, request, URLString, param);
        return;
    }
    
    NSArray * allKeys = param.allKeys;
    if (allKeys.count == 0) {
        DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@", header, request, URLString);
    } else {
        NSArray * allValues = param.allValues;
        NSMutableString * paramStr = [NSMutableString string];
        if ([request isEqualToString:@"GET"]) {
            for (int i = 0; i < allKeys.count; i ++) {
                if (i != 0) {
                    [paramStr appendFormat:@"&"];
                }
                [paramStr appendFormat:@"%@=%@", allKeys[i], allValues[i]];
            }
            DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@?%@", header, request, URLString, paramStr);
        } else {
            paramStr = [self dictionarytToJsonData:param];
            DLog(@"请求头:x-qqw-token=%@\n请求方式:%@\n请求链接:%@\n请求参数:\n%@", header, request, URLString, paramStr);
        }
    }
}




- (NSMutableString *)dictionarytToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    
    if (!jsonData) {
        NSLog(@"%@",error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    NSRange range = {0,jsonString.length};
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//    NSRange range2 = {0,mutStr.length};
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

#pragma mark ---- Lazy
- (NSMutableArray *)requestArray
{
    if (!_requestArray) {
        _requestArray = [NSMutableArray array];
    }
    
    return _requestArray;
}

- (NSString *)getApiUrl
{
    return BaseUrl;
}
    
@end
