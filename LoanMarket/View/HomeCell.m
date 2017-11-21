//
//  HomeCell.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "HomeCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "GQUIControl.h"

@interface HomeCell ()

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic, strong)UILabel *loanLabel;
@property (nonatomic, strong)UILabel *loanNumLabel;
@property (nonatomic, strong)UILabel *rateLabel;
@property (nonatomic, strong)UILabel *rateDesLabel;
@property (nonatomic, strong)UIImageView *iconImageView;

@end

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:12] textColor:RGB(56,56,56) textAlignment:NSTextAlignmentLeft];
    }
    return self;
}




@end
