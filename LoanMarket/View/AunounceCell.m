//
//  ScrollAdView.m
//  LoanMarket
//
//  Created by gap on 2017/11/25.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "AunounceCell.h"
#import <Masonry.h>
#import "GQUIControl.h"


static NSInteger baseTag = 1099;

@interface AunounceCell () <UIScrollViewDelegate>

@property (nonatomic, strong)UILabel *tipLable;

@property (nonatomic, strong)UILabel *lineLabel;

@property (nonatomic, strong)UIScrollView *contentScroll;

@property (nonatomic, strong)NSMutableArray <__kindof UILabel *>*labelArray;

@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, assign)NSInteger acountArray;

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation AunounceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tipLable = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:21] textColor:RGB(253, 153, 50) textAlignment:NSTextAlignmentCenter];
        self.tipLable.text = @"公告";
        [self.contentView addSubview:self.tipLable];
        
        self.lineLabel = [[UILabel alloc] init];
        self.lineLabel.backgroundColor = grayColor;
        [self.contentView addSubview:self.lineLabel];
        
//        self.contentScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
//        [self.contentView addSubview:self.contentScroll];
        
        [self.tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        }];
        
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(0.5);
            make.left.mas_equalTo(self.tipLable.mas_right).offset(10);
        
        }];
        
        self.labelArray = [NSMutableArray arrayWithCapacity:4];
        
        self.contentScroll = [GQUIControl scrollViewWithFrame:CGRectMake(80, 0, SCREEN_WIDTH - 80, 50) contentSize:CGSizeZero showVer:NO showHor:NO delegate:self IStranslatesAutoresizingMask:NO];
        self.contentScroll.scrollEnabled = NO;
        [self.contentView addSubview:self.contentScroll];
        
        self.cellHeight = 50;
        
        self.timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        self.dataArray = [[NSArray alloc] init];
    }
    return self;
}

- (void)setupAunounceScroll:(NSArray *)array {
    
    if ([self.dataArray isEqualToArray:array]) {
        
    } else {
        self.dataArray = array;
        
        for (UILabel *lable in self.contentScroll.subviews) {
            [lable removeFromSuperview];
        }
        
        [self initWithArray:array];
    }
 

}

- (void)initWithArray:(NSArray *)array {
    CGFloat labelWidth = SCREEN_WIDTH - 80;
    self.acountArray = array.count;
    
    if (array.count > 1) {
        self.contentScroll.contentSize = CGSizeMake(labelWidth, _cellHeight*(array.count + 2));
    } else {
        self.contentScroll.contentSize = CGSizeMake(labelWidth, _cellHeight);
    }
    
    for (int i = 0; i<array.count; i++) {
        UILabel *label = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentLeft];
        label.text = array[i];
        if (array.count > 1) {
            label.frame = CGRectMake(0, _cellHeight * (i+1), labelWidth, _cellHeight);
        } else {
            label.frame = CGRectMake(0, _cellHeight * i, labelWidth, _cellHeight);
        }
        [self.contentScroll addSubview:label];
        
        label.userInteractionEnabled = YES;
        label.tag = baseTag + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        [label addGestureRecognizer:tap];
    }
    
    if (array.count > 1) {
        
        UILabel *firstLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentLeft];
        firstLabel.frame = CGRectMake(0, 0, labelWidth, _cellHeight);
        firstLabel.text = array.lastObject;
        [self.contentScroll addSubview:firstLabel];
        
        UILabel *lastLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentLeft];
        lastLabel.text = array[0];
        lastLabel.frame = CGRectMake(0, _cellHeight * (array.count + 1) , labelWidth, _cellHeight);
        [self.contentScroll addSubview:lastLabel];
        
    }
    
    [self.contentScroll scrollRectToVisible:CGRectMake(0, _cellHeight, labelWidth, _cellHeight) animated:NO];
}

- (void)nextPage {
    CGPoint contentOffset = self.contentScroll.contentOffset;
    contentOffset.y = contentOffset.y + _cellHeight;
    [self.contentScroll setContentOffset:contentOffset animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y / _cellHeight >= self.acountArray + 1) {
        scrollView.contentOffset = CGPointMake(0, _cellHeight);

    }
    
    if (scrollView.contentOffset.y == 0) {
        scrollView.contentOffset = CGPointMake(0, _cellHeight *self.acountArray);
    }
}

- (void)labelClick:(UITapGestureRecognizer *)sender {
    
}

@end




