//
//  LoanAreaCell.h
//  LoanMarket
//
//  Created by gap on 2018/9/17.
//  Copyright © 2018年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductDetailModel;

@interface LoanAreaCell : UITableViewCell

- (void)configureCell:(ProductDetailModel *)model;

@end

@interface GuideConditionCell : UITableViewCell
@end
