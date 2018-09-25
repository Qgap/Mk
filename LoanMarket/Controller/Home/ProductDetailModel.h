//
//  ProductDetailModel.h
//  LoanMarket
//
//  Created by gap on 2018/9/20.
//  Copyright © 2018年 gq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject


@property (nonatomic,copy) NSString *applyUrl;
@property (nonatomic,copy) NSString *bannerInfo;
@property (nonatomic,copy) NSString *interestComprehensive;
@property (nonatomic,copy) NSString *loanAmount;
@property (nonatomic,copy) NSString *loanCount;
@property (nonatomic,copy) NSString *loanTerm;
@property (nonatomic,copy) NSString *logoUrl;
@property (nonatomic,copy) NSString *notice;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *quotaAvg;
@property (nonatomic,copy) NSString *slogan;
@property (nonatomic,copy) NSString *timeAvg;

@property (nonatomic,strong) NSArray *applyInfo;

@end


//@interface ApplyInfoModel : NSObject
//
//@end
