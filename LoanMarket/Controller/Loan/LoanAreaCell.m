//
//  LoanAreaCell.m
//  LoanMarket
//
//  Created by gap on 2018/9/17.
//  Copyright © 2018年 gq. All rights reserved.
//

#import "LoanAreaCell.h"
#import <Masonry.h>

@interface LoanAreaCell ()
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIImageView *markImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *amountLabel;
@property(nonatomic,strong)UILabel *peopleLabel;

@end

@implementation LoanAreaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
        
    }
    return self;
    
}

- (void)initUI {
    self.iconImageView = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [GQUIControl labelWithTextFont:Font16 textColor:black_light textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.titleLabel];
    
    self.amountLabel = [GQUIControl labelWithTextFont:Font14 textColor:gray_Color textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.amountLabel];
    
    self.peopleLabel = [GQUIControl labelWithTextFont:Font14 textColor:gray_Color textAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.peopleLabel];
    
    self.markImageView = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
    [self.contentView addSubview:self.markImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WIDTH_SCALE);
        make.size.mas_equalTo(CGSizeMake(50 * WIDTH_SCALE, 50 * WIDTH_SCALE));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    
    [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(self.markImageView.mas_height);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(20 * WIDTH_SCALE);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10 * WIDTH_SCALE);
        make.right.mas_equalTo(self.markImageView.mas_left);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5 * WIDTH_SCALE);
    }];
    
    [self.peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.titleLabel.mas_right);
        make.top.mas_equalTo(self.amountLabel.mas_bottom).offset(5 * WIDTH_SCALE);
    }];
    
    self.markImageView.image = [UIImage imageNamed:@"subscript"];
    self.iconImageView.image = [UIImage imageNamed:@"apply_icon"];
    self.titleLabel.text = @"胡歌最帅";
    self.amountLabel.text = @"hu ge handsome";
    self.peopleLabel.text = @"10000人";
}

- (void)setUpCell:(id)model {
    
}


@end


