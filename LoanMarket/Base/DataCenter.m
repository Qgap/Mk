//
//  DataCenter.m
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "DataCenter.h"

static NSString *const token = @"X-TOKEN";
static NSString *const phone = @"Phone";

@implementation DataCenter

+ (instancetype)sharedInstance {
    
    static DataCenter *dataCenter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCenter = [[DataCenter alloc] init];
    });
    
    return dataCenter;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *userToken = [[NSUserDefaults standardUserDefaults] valueForKey:token];
        if (userToken && userToken.length > 0) {
            self.userToken = userToken;
        }
        
    }
    
    return self;
}

- (void)loginSucceedWithData:(id)data {
    self.userToken = data[@"token"];
    self.phoneNO = data[@"phoneNo"];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.userToken forKey:token];
    [userDefault setObject:self.phoneNO forKey:phone];
    [userDefault synchronize];
    
}

@end
