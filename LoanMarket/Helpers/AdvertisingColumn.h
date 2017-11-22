//
//  AdvertisingColumn.h
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisingColumn : UIView

@property (nonatomic, copy) void (^adImageClick)(UITapGestureRecognizer *tap);

@end
