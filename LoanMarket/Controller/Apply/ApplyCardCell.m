//
//  ApplyCardCell.m
//  LoanMarket
//
//  Created by gap on 2018/9/16.
//  Copyright © 2018年 gq. All rights reserved.
//

#import "ApplyCardCell.h"
#import "CardListModel.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface ApplyCardCell ()
@property (nonatomic,strong)UIImageView *iconImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;

@end

@implementation ApplyCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI {
    self.iconImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImage];
    
    self.titleLabel = [GQUIControl labelWithTextFont:Font16 textColor:black_Color textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [GQUIControl labelWithTextFont:Font13 textColor:gray_Color textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.detailLabel];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WIDTH_SCALE);
        make.top.mas_equalTo(self.contentView.mas_top).offset(19 * WIDTH_SCALE);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-19 * WIDTH_SCALE);
        make.width.mas_equalTo(104 * WIDTH_SCALE);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImage.mas_right).offset(15 * WIDTH_SCALE);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WIDTH_SCALE);
        make.top.mas_equalTo(self.contentView.mas_top).offset(29 * WIDTH_SCALE);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImage.mas_right).offset(15 * WIDTH_SCALE);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WIDTH_SCALE);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10 * WIDTH_SCALE);
    }];
    
//    self.titleLabel.text = @"浦发银行信用卡";
//    self.detailLabel.text = @"白金卡 免年费";
}

- (void)configureCell:(CardListModel *)model {
    self.titleLabel.text = model.bankName;
    self.detailLabel.text = model.bankBanner;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.bankIconUrl] placeholderImage:nil];
}

@end
