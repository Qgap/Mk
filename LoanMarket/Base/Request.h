//
//  GQRequest.h
//  Finance
//
//  Created by gap on 2017/11/29.
//  Copyright © 2017年 cyfuer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>
#import <YYModel.h>

typedef void(^completion)(BOOL success, id responseObject, NSError *error);


@interface Request : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params completion:(completion)completion;

+ (void)postURL:(NSString *)url params:(NSDictionary *)params completion:(completion)completion;

+ (NSMutableURLRequest *)setHeaders:(NSMutableURLRequest *)request;

@end
