//
//  GQRequest.m
//  Finance
//
//  Created by gap on 2017/11/29.
//  Copyright © 2017年 cyfuer. All rights reserved.
//

#import "Request.h"
#import <AFNetworking.h>
//#import "SystemServices.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "DataCenter.h"

static const NSString *API_KEY = @"pmjWn6kLz6mcQf2N";
static const NSString *SECURITY_KEY = @"1cLLub8UOLvlT69ITSBFgHX50f9T4rOG";

@interface Request ()

@end

@implementation Request

+ (void)get:(NSString *)url params:(NSDictionary *)params completion:(completion)completion {

}

+ (void)postURL:(NSString *)url params:(NSDictionary *)params completion:(completion)completion {
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    
    manager.responseSerializer = responseSerializer;
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@",domainURL,url] parameters:nil error:nil];
    
    request = [self setHeaders:request];
    
    if (params != nil) {
        
        NSData *data= [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    }
    
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
        });
        
        if (error) {
            NSLog(@"response :%@ error localizedDescription :%@",response.URL,error.localizedDescription);
            
            completion(false,nil,error);
            
        } else {
            id json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            NSInteger code = [json[@"code"] integerValue] ;
            NSString *message = json[@"message"];
            
            if ( code == 1) {
                
                NSLog(@"requst url :%@ , params :%@, responsedata :%@",request.URL,params,json);
                completion(true,json,nil);
                
            } else {
                
                NSLog(@"error code :%ld , error message :%@ ",error.code,message);
                
                completion(false,nil,[[NSError alloc] initWithDomain:message code:code userInfo:nil]);
                
                if (code == 19902 ||code == 19903 ) {
                    
                    dispatch_main_sync_safe(^{
//                        LoginViewController *login = [[LoginViewController alloc] init];
                        UINavigationController *login = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
                        AppDelegate *appdelegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        [appdelegate.mainVC presentViewController:login animated:YES completion:^{

                        }];
                    });

                }
            }
        }
        
    }] resume];


}

+ (NSMutableURLRequest *)setHeaders:(NSMutableURLRequest *)request {
    
    
    [request setValue:[DataCenter sharedInstance].userToken forHTTPHeaderField:@"X-Token"];
    
//    [request setValue:@"1.0.1" forHTTPHeaderField:@"X-Version"];//系统版本号
//    [request setValue:@"10.0.1" forHTTPHeaderField:@"X-OSVersion"];//系统平台
//    [request setValue:@"iOS" forHTTPHeaderField:@"X-Platform"];//时间戳
//    [request setValue:@"" forHTTPHeaderField:@"com.xx.xx.xx"];//设备串号
//    [request setValue:@"iwifi-offical" forHTTPHeaderField:@"X-Channel"];//IMSI(可能为null)
    
//    [request setValue:@"2000000" forHTTPHeaderField:@"X-Timestamp"];//加密签名
    
//    NSString *signStr = [NSString stringWithFormat:@"%@|%@|%@|%@",SECURITY_KEY,API_KEY,@"2000000",SECURITY_KEY];
    
//    [request setValue:[self MD5:signStr] forHTTPHeaderField:@"X-SignInfo"];//加密签名
//    [request setValue: token forHTTPHeaderField:@"X-Token"];//加密签名
    
    
//    [request setValue:@"" forHTTPHeaderField:@"If-None-Match"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}




@end
