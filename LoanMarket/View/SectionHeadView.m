//
//  SectionHeadView.m
//  LoanMarket
//
//  Created by gap on 2017/11/26.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "SectionHeadView.h"
#import "GQUIControl.h"

@interface SectionHeadView ()

@property (nonatomic, strong)UIView *lineView;

@end

@implementation SectionHeadView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 3, 16)];
        self.lineView.backgroundColor = themeColor;
        [contentView addSubview:self.lineView];
        
        self.titleLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:16] textColor:themeColor textAlignment:NSTextAlignmentLeft];
        self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.lineView.frame) + 5, 15, 300, 16);
        [contentView addSubview:self.titleLabel];
    
    }
    
    return self;
}

@end
