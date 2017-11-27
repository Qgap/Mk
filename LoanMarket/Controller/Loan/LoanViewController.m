//
//  LoanViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "LoanViewController.h"
#import <Masonry.h>
#import "HomeLoanCell.h"
#import "GQUIControl.h"

static NSString *const cellId = @"CELLID";

typedef NS_ENUM (NSInteger, sortMethod)  {
    sortByDefault,
    sortByAmount
};

@interface LoanViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation LoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"贷款搜索";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view addSubview:self.tableView];
    [self setupHeadView];
}

- (void)setupHeadView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = [UIColor whiteColor];
    CALayer *bottomLayer = [GQUIControl layerWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)
                                           borderColor:RGB(106, 106, 106)];
    bottomLayer.backgroundColor = RGB(84, 84, 84).CGColor;
    [headView.layer addSublayer:bottomLayer];
    [self.view addSubview:headView];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectZero];
    [headView addSubview:leftView];
    
    UILabel *defaultSortLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentCenter];
    defaultSortLabel.text = @"默认排序";
    [leftView addSubview:defaultSortLabel];
    
    UIImageView *arrowImage = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
    arrowImage.image = [UIImage imageNamed:@"arrow_down"];
    [leftView addSubview:arrowImage];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2.0, 50));
    }];
    
    [defaultSortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.right.mas_equalTo(arrowImage.mas_left).offset(-5);
    }];
    
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.left.mas_equalTo(defaultSortLabel.mas_right).offset(5);
        make.right.mas_equalTo(leftView.mas_right).offset(-40);
        make.width.mas_equalTo(@20);
    }];
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectZero];
    [headView addSubview:rightView];
    
    UILabel *amountLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentCenter];
    amountLabel.text = @"金额不限";
    [rightView addSubview:amountLabel];
    
    UIImageView *rightArrowImage = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
    rightArrowImage.image = [UIImage imageNamed:@"arrow_down"];
    [rightView addSubview:rightArrowImage];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headView.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2.0, 50));
    }];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightView.mas_centerY);
        make.left.mas_equalTo(rightView.mas_left).offset(40);
        make.right.mas_equalTo(rightArrowImage.mas_left).offset(-5);
    }];
    
    [rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightView.mas_centerY);
        make.left.mas_equalTo(amountLabel.mas_right).offset(5);
        make.width.mas_equalTo(@20);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 11, 1, 28)];
    lineView.backgroundColor = RGB(106, 106, 106);
    [rightView addSubview:lineView];


    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSort:)];
    leftView.tag = sortByDefault;
    [leftView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSort:)];
    rightView.tag = sortByAmount;
    [rightView addGestureRecognizer:rightTap];
}

- (void)changeSort:(UITapGestureRecognizer *)sender {
    if (sender.view.tag == sortByDefault) {
        NSLog(@"default");
    } else {
        NSLog(@"ammount");
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomeLoanCell class] forCellReuseIdentifier:cellId];
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
