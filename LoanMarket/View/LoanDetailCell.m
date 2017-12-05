//
//  LoanDetailCell.m
//  LoanMarket
//
//  Created by gap on 2017/12/3.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "LoanDetailCell.h"
#import "GQUIControl.h"

@interface LoanDetailCell ()

@end

@implementation LoanDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray *contentArray = @[@"14天",@"3000元",@"1小时",@"6%"];
        NSArray *titleArray = @[@"平均期限",@"平均额度",@"平均用时",@"月利率"];
        for (int i = 0; i < 2; i ++ ) {
            for (int j = 0; j < 4; j++) {
                LabelView *labelView = [[LabelView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 4.0 * j, 60 *i, SCREEN_WIDTH / 4.0, 60)];
                [self.contentView addSubview:labelView];
                [labelView setupContent:contentArray[j] title:titleArray[j] rightLayerHidden:j == 3 ? YES : NO];
            }
        }
        
    }
    return self;
    
}
@end


@interface LabelView ()

@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)CALayer *rightLayer;

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
        
        self.rightLayer = [GQUIControl layerWithFrame:CGRectMake(width -0.5, 0, 0.5, height) borderColor:RGB(106, 106, 106)];
        [self.layer addSublayer:self.rightLayer];
        
    }
    return self;
}

- (void)setupContent:(NSString *)content title:(NSString *)title rightLayerHidden:(BOOL)hidden {
    self.contentLabel.text = content;
    self.titleLabel.text = title;
    self.rightLayer.hidden = hidden;
}

@end
