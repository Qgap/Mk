//
//  Validator.h
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

/**
 *  判断输入的是否为正确的邮箱
 *
 *  @param Email 邮箱号
 *
 *  @return 判断后的结果
 */
+ (BOOL)isValidateEmail:(NSString *)Email;

/**
 *  判断输入是不是正确的手机号格式
 */
+ (BOOL) isValidateMobile:(NSString *)mobile;

@end
