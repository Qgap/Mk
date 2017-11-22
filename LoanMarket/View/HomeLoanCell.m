//
//  HomeCell.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "HomeLoanCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "GQUIControl.h"

@interface HomeLoanCell ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic, strong)UILabel *loanLabel;
@property (nonatomic, strong)UILabel *loanNumLabel;
@property (nonatomic, strong)UILabel *rateLabel;
@property (nonatomic, strong)UILabel *rateDesLabel;
@property (nonatomic, strong)UIImageView *iconImageView;

@end

@implementation HomeLoanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:16]
                                               textColor:RGB(56,56,56)
                                           textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.titleLabel];
        
        self.iconImageView = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.iconImageView];
        
        self.desLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:15]
                                             textColor:RGB(154, 154, 154)
                                         textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.desLabel];
        
        self.loanLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:13]
                                              textColor:grayColor
                                          textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.loanLabel];
        
        self.loanNumLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:13]
                                                 textColor:orangeColor
                                             textAlignment:NSTextAlignmentLeft];
        self.loanNumLabel.layer.borderColor = orangeColor.CGColor;
        self.loanNumLabel.layer.borderWidth = 0.5;
        self.loanNumLabel.layer.cornerRadius = 5;
        [self.contentView addSubview:self.loanNumLabel];
        
        self.rateLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:13]
                                              textColor:orangeColor
                                          textAlignment:NSTextAlignmentRight];
        
        [self.contentView addSubview:self.rateLabel];
        
        self.rateDesLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:13]
                                                 textColor:grayColor
                                             textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.rateDesLabel];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        }];
        
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        }];
        
        [self.loanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_left);
            make.top.mas_equalTo(self.desLabel.mas_bottom).offset(5);
        }];
        
        [self.loanNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.loanLabel.mas_right).offset(2);
            make.top.mas_equalTo(self.desLabel.mas_bottom).offset(5);
        }];
        
        [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        }];
        
        [self.rateDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.top.mas_equalTo(self.rateLabel.mas_bottom).offset(5);
            
        }];
        
        
        self.titleLabel.text = @"急用钱";
        
        self.desLabel.text = @"0抵押，2000闪现到账";
        
        self.loanLabel.text = @"贷款额度";
        
        self.loanNumLabel.text = @"  500～2000 ";
        
        self.rateLabel.text = @"0.03%";
        
        self.rateDesLabel.text = @"日利率";
    }
    return self;
}

- (void)setupCellWithData:(id)data {
    
}

@end




