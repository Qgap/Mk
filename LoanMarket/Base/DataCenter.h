//
//  DataCenter.h
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataCenter : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic,copy)NSString *userToken;
@property(nonatomic,copy)NSString *phoneNO;

- (void)loginSucceedWithData:(id)data;

@end
