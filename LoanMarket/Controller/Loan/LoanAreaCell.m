//
//  LoanAreaCell.m
//  LoanMarket
//
//  Created by gap on 2018/9/17.
//  Copyright © 2018年 gq. All rights reserved.
//

#import "LoanAreaCell.h"
#import <Masonry.h>
#import "ProductDetailModel.h"
#import <UIImageView+WebCache.h>

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

}

- (void)configureCell:(ProductDetailModel *)model {
    self.markImageView.image = [UIImage imageNamed:@"subscript"];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.logoUrl] placeholderImage:[UIImage imageNamed:@"apply_icon"]];
    self.titleLabel.text = model.productName;
    NSString *amountString = [NSString stringWithFormat:@"贷款金额：%@元",model.loanAmount];
    NSString *peopleString = [NSString stringWithFormat:@"贷款人数：%@人",model.loanCount];
    self.amountLabel.attributedText = [self fullString:amountString attribuString:model.loanAmount];
    self.peopleLabel.attributedText = [self fullString:peopleString attribuString:model.loanCount];
}

- (NSAttributedString *)fullString:(NSString *)fullString attribuString:(NSString *)text {
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:fullString];

    [attString addAttribute:NSForegroundColorAttributeName value:orangeColor range:NSMakeRange(5, text.length + 1)];
    
    return attString;
    
}

@end

@interface GuideConditionCell ()

@end

@implementation GuideConditionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
        
    }
    return self;
    
}

- (void)initUI {
    NSArray *typeArray = @[@"电商账号",@"芝麻分",@"信用卡",@"手机认证",@"征信报告"];
    NSArray *iconArray = @[@"apply_icon",@"register_icon",@"info_icon",@"review_icon"];
    NSArray *stepArray = @[@"申请贷款",@"注册/登录",@"完善资料",@"审核放款"];
    float labelWidth = 10 * WIDTH_SCALE;
    
    for (int i = 0; i<typeArray.count; i ++) {
        UILabel *label = [GQUIControl labelWithTextFont:Font14 textColor:black_Color textAlignment:NSTextAlignmentCenter];
        label.text = typeArray[i];
        [self.contentView addSubview:label];
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 12;
        label.layer.borderColor = RGB(189,189,189).CGColor;
     
        CGSize size = [typeArray[i] sizeWithAttributes:@{NSFontAttributeName:Font14}];
        label.frame = CGRectMake(labelWidth, 10, size.width + 15 *WIDTH_SCALE, 26);
        
        labelWidth = CGRectGetMaxX(label.frame) + 4;
    }
    
    for (int i = 0; i < iconArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconArray[i]]];
        [self.contentView addSubview:imageView];
        
        imageView.frame = CGRectMake(26 * WIDTH_SCALE + 91 * WIDTH_SCALE *i, 46, 50 * WIDTH_SCALE, 50*WIDTH_SCALE);
        
//        UIImageView *arrowImage = [[UIImageView alloc] init];
//        arrowImage.image = [UIImage imageNamed:@""];
//        [self.contentView addSubview:arrowImage];
        
        UILabel *textLabel = [GQUIControl labelWithTextFont:Font14 textColor:blackColor textAlignment:NSTextAlignmentCenter];
        textLabel.text = stepArray[i];
        
        [self.contentView addSubview:textLabel];
        
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(imageView.mas_centerX);
            make.top.mas_equalTo(imageView.mas_bottom).offset(10);
        }];
    }
}

@end


