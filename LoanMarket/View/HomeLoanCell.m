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
#import "ProductModel.h"

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
        
//        self.iconImageView.image = [UIImage imageNamed:@"defalut_icon"];
        
//        self.titleLabel.text = @"急用钱";
//
//        self.desLabel.text = @"0抵押，2000闪现到账";
//
//        self.loanLabel.text = @"贷款额度";
//
//        self.loanNumLabel.text = @"  500～2000 ";
//
//        self.rateLabel.text = @"0.03%";
        
        self.rateDesLabel.text = @"利率";
    }
    return self;
}

- (void)configureCell:(ProductModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:@"defalut_icon"]];
    self.titleLabel.text = model.productName;
    self.rateLabel.text = model.interestComprehensive;
    self.loanNumLabel.text = model.quotaAvg;
    self.desLabel.text = model.slogan;
}


@end

@interface HotRecommendCell ()

@property (nonatomic, strong)NSMutableArray <UIImageView *> *iconImage;

@end

@implementation HotRecommendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        CGFloat hovGap = 15;
        for ( int i = 0; i < 3; i ++) {
            
            UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            iconButton.frame = CGRectMake(hovGap, 10, 101*WIDTH_SCALE, 101*WIDTH_SCALE);
            
            [iconButton setBackgroundImage:[UIImage imageNamed:@"hot_recommand"]
                                  forState:UIControlStateNormal];
            
            [iconButton addTarget:self
                           action:@selector(recommendClick:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            iconButton.adjustsImageWhenHighlighted = NO;
            
            [self.contentView addSubview:iconButton];
            
            hovGap += WIDTH_SCALE * 122;
            
        }
        
//        UIView *bottomLine = [[UIView alloc] init];
//        bottomLine.backgroundColor = grayColor;
//        bottomLine.frame = CGRectMake(0, self.contentView.frame.size.height - 2, SCREEN_WIDTH, 2);
//        [self.contentView addSubview:bottomLine];
    
    }
    return self;
}

- (void)recommendClick:(UIButton *)sender {
    
}

@end

#pragma mark - LoanTypeCell

@interface LoanTypeCell ()

@end

@implementation LoanTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI {
    NSArray *titleArray = @[@"身份证贷",@"信用卡贷",@"大额贷",@"抵押贷"];
    NSArray *iconArray = @[@"idCard_loan",@"credit_loan",@"large_loan",@"mortgage_loan"];
    
    for (int i = 0; i < titleArray.count; i ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH / 4.0 * i, 0, SCREEN_WIDTH / 4.0, 80);
        [button addTarget:self action:@selector(loanTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.contentView addSubview:button];
        
        UIImageView *iconImageView = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
        iconImageView.image = [UIImage imageNamed:iconArray[i]];
        [button addSubview:iconImageView];
        
        UILabel *titleLabel = [GQUIControl labelWithTextFont:Font14 textColor:blackColor textAlignment:NSTextAlignmentCenter];
        titleLabel.text = titleArray[i];
        [button addSubview:titleLabel];
        
        titleLabel.frame = CGRectMake(0, 50, SCREEN_WIDTH / 4.0, 20);
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(27, 20));
            make.centerX.mas_equalTo(button.mas_centerX);
            make.top.mas_equalTo(button.mas_top).offset(18);
        }];
        
      
    }
}

- (void)loanTypeAction:(UIButton *)sender {
    if (self.loanTypeButton) {
        self.loanTypeButton(sender);
    }
}

@end

#pragma mark - FunctionAreaCell

@interface FunctionAreaCell ()

@end

@implementation FunctionAreaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI {
    NSArray *titleArray = @[@"贷款大全",@"办信用卡"];
    NSArray *descriptionArray = @[@"汇集各类网贷",@"下卡快额度高"];
    NSArray *iconArray = @[@"allLoan_icon",@"apply_card"];
    
    for (int i = 0; i < titleArray.count; i ++ ) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(SCREEN_WIDTH / 2.0 * i, 0, SCREEN_WIDTH / 2.0, 69);
//        [button addTarget:self action:@selector(loanTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.contentView addSubview:button];
        
        UIImageView *iconImageView = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
        iconImageView.image = [UIImage imageNamed:iconArray[i]];
        [button addSubview:iconImageView];
        
        UILabel *titleLabel = [GQUIControl labelWithTextFont:Font14 textColor:blackColor textAlignment:NSTextAlignmentLeft];
        titleLabel.text = titleArray[i];
        [button addSubview:titleLabel];
        
        UILabel *desLabel = [GQUIControl labelWithTextFont:Font13 textColor:grayColor textAlignment:NSTextAlignmentLeft];
        desLabel.text = descriptionArray[i];
        [button addSubview:desLabel];
        
        if (i == 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 0.5, 0, 0.5, 69 * WIDTH_SCALE)];
            lineView.backgroundColor = grayColor;
            [button addSubview:lineView];
        }
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(35, 33));
            make.centerY.mas_equalTo(button.mas_centerY);
            make.left.mas_equalTo(button.mas_left).offset(30 * WIDTH_SCALE);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconImageView.mas_top);
            make.left.mas_equalTo(iconImageView.mas_right).offset(15);
            make.right.mas_equalTo(button.mas_right);
        }];
        
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
            make.left.mas_equalTo(titleLabel.mas_left);
            make.right.mas_equalTo(button.mas_right);
        }];
        
    }
}


@end


