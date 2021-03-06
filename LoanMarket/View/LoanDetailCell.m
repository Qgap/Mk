//
//  LoanDetailCell.m
//  LoanMarket
//
//  Created by gap on 2017/12/3.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "LoanDetailCell.h"
#import "GQUIControl.h"
#import <Masonry.h>
#import "ProductDetailModel.h"
#import "NSString+AttributeString.h"

static CGFloat gapLeft = 15;

@interface LoanDetailCell ()

@property (nonatomic,strong)NSMutableArray <LabelView *> *labelViewArray;

@property (nonatomic, strong)UILabel *tipLabel;

@end

@implementation LoanDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
     
        
    }
    return self;
    
}

- (void)initUI {
    NSArray *contentArray = @[@"14天",@"3000元",@"1小时",@"6%"];
    NSArray *titleArray = @[@"平均期限",@"平均额度",@"平均用时",@"利率"];
    self.labelViewArray = [NSMutableArray arrayWithCapacity:10];
    

    for (int j = 0; j < 4; j++) {
        LabelView *labelView = [[LabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4.0 * j, 0, SCREEN_WIDTH / 4.0, 60)];
        [self.contentView addSubview:labelView];
        [self.labelViewArray addObject:labelView];
        
        [labelView setupContent:contentArray[j] title:titleArray[j] rightLayerHidden:j == 3 ? YES : NO];
    }

    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 42)];
    backgroundView.backgroundColor = RGB(205,240,236);
    [self.contentView addSubview:backgroundView];
    self.tipLabel = [GQUIControl labelWithTextFont:Font14 textColor:RGB(20,200,179) textAlignment:NSTextAlignmentLeft];
    
    self.tipLabel.numberOfLines = 0;
    [backgroundView addSubview:self.tipLabel];
    
//    self.tipLabel.frame = CGRectMake(15 * WIDTH_SCALE, 0, SCREEN_WIDTH - 30 * WIDTH_SCALE, 42);
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(self.contentView.mas_top).offset(60);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];

    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15 * WIDTH_SCALE);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15 * WIDTH_SCALE);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.top.mas_equalTo(backgroundView.mas_top);
    }];
}

- (void)configureCell:(ProductDetailModel *)model {
    self.tipLabel.attributedText = [NSString setTextLineSpace:5 withString:model.slogan withFont:14];
    
    [self.labelViewArray enumerateObjectsUsingBlock:^(LabelView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                obj.contentLabel.text = model.loanTerm;
                
                break;
            case 1:
                obj.contentLabel.text = model.quotaAvg;
                break;
                
            case 2:
                obj.contentLabel.text = model.timeAvg;
                break;
            case 3:
                obj.contentLabel.text = model.interestComprehensive;
                break;
                
            default:
                break;
        }
    }];
}

@end


@interface LabelView ()

@end

@implementation LabelView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        self.contentLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:orangeColor textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.contentLabel];
        
        self.contentLabel.frame = CGRectMake(0, 10, width, 20);
        
        self.titleLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame) + 2, width, 20);
        
        CALayer *topLayer = [GQUIControl layerWithFrame:CGRectMake(0, 0, width, 0.5) borderColor:RGB(106, 106, 106)];
        [self.layer addSublayer:topLayer];
        
//        self.rightLayer = [GQUIControl layerWithFrame:CGRectMake(width -0.5, 0, 0.5, height) borderColor:RGB(106, 106, 106)];
//        [self.layer addSublayer:self.rightLayer];
        
    }
    return self;
}

- (void)setupContent:(NSString *)content title:(NSString *)title rightLayerHidden:(BOOL)hidden {
    self.contentLabel.text = content;
    self.titleLabel.text = title;
    self.rightLayer.hidden = hidden;
}


@end





@interface ConditionCell ()

@end

@implementation ConditionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *dotImage = [[UIImageView alloc] init];
        dotImage.image = [UIImage imageNamed:@"dot_list"];
        [self.contentView addSubview:dotImage];
        
        self.titleLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14]
                                               textColor:RGB(106, 106, 106)
                                           textAlignment:NSTextAlignmentLeft];
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel sizeToFit];
        [self.contentView addSubview:self.titleLabel];
        
        [dotImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(gapLeft);
            make.size.mas_equalTo(CGSizeMake(5, 5));
//            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.top.mas_equalTo(self.titleLabel.mas_top).offset(5);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(dotImage.mas_right).offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-gapLeft);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return self;
}

@end
