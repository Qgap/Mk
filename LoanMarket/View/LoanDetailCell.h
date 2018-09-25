//
//  LoanDetailCell.h
//  LoanMarket
//
//  Created by gap on 2017/12/3.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductDetailModel;

@interface LoanDetailCell : UITableViewCell

- (void)configureCell:(ProductDetailModel *)model;

@end

@interface LabelView : UIView

@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)CALayer *rightLayer;

- (void)setupContent:(NSString *)content title:(NSString *)title rightLayerHidden:(BOOL)hidden;

@end

@interface ConditionCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;

@end
