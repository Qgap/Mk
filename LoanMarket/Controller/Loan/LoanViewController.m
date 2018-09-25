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
#import "MenuView.h"
#import "Request.h"
#import "ProductModel.h"
#import "DataCenter.h"

static NSString *const cellId = @"CELLID";
static NSString *const typeDefaultString = @"贷款类型";
static NSString *const sortDefaultString = @"默认排序";

typedef NS_ENUM (NSInteger, sortMethod)  {
    sortByDefault,
    sortByAmount
};

@interface LoanViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *loanTypeArray;
@property (nonatomic,strong) NSArray *sortArray;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *sortLabel;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation LoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"贷款搜索";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.loanTypeArray = @[@"身份证贷",@"信用卡贷",@"大额贷",@"抵押贷",@"贷款类型"];
    self.sortArray = @[@"金额正序",@"金额倒序",@"默认排序"];
    
    [self.view addSubview:self.tableView];
    [self setupHeadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *loanType = [DataCenter sharedInstance].loanType;
    
    if (loanType && ![loanType isEqualToString:@""]) {
        self.typeLabel.text = loanType;
    } else {
        self.typeLabel.text = typeDefaultString;
    }
    
    self.sortLabel.text = sortDefaultString;
    
    [self loadRequest];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [DataCenter sharedInstance].loanType = @"";
}

- (void)loadRequest {
    [SVProgressHUD show];
    
    NSString *sortType = @"";
    NSString *loanType = @"";
    if ([self.sortLabel.text isEqualToString:sortDefaultString]) {
        sortType = @"金额正序";
    } else {
        sortType = self.sortLabel.text;
    }
    
    if ([self.typeLabel.text isEqualToString:typeDefaultString]) {
        loanType = @"身份证贷";
    } else {
        loanType = self.typeLabel.text;
    }
    
    [Request postURL:productAllList params:@{@"sortType":sortType,@"loanType":loanType} completion:^(BOOL success, id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"response :%@",responseObject);
        
        if (success) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[ProductModel class] json:responseObject[@"data"]];
            [self.tableView reloadData];
        }
        
    }];
}

- (void)changeSort:(UITapGestureRecognizer *)sender {
    
    if (sender.view.tag == sortByDefault) {
        CGRect rect = [self.sortLabel convertRect:self.sortLabel.frame toView:self.view];
        
        MenuView *menuView = [[MenuView alloc] initWithFrame:rect withArray: self.sortArray];
        menuView.Selector = ^(NSString *text) {
            self.sortLabel.text = text;
            
            [self loadRequest];
        };
        
        [self.view addSubview:menuView];
        
    } else {
        CGRect rect = [self.typeLabel convertRect:self.typeLabel.frame toView:self.view];
        
        MenuView *menuView = [[MenuView alloc] initWithFrame:rect withArray: self.loanTypeArray];
        menuView.Selector = ^(NSString *text) {
            self.typeLabel.text = text;
            [self loadRequest];
        };
        [self.view addSubview:menuView];
    }
}



#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell configureCell:self.dataArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
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

#pragma mark - UI

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
    
    self.sortLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentCenter];
    self.sortLabel.text = sortDefaultString;
    [leftView addSubview:self.sortLabel];
    
    UIImageView *arrowImage = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
    arrowImage.image = [UIImage imageNamed:@"arrow_down"];
    [leftView addSubview:arrowImage];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2.0, 50));
    }];
    
    [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.right.mas_equalTo(arrowImage.mas_left).offset(-5);
    }];
    
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.left.mas_equalTo(self.sortLabel.mas_right).offset(5);
        make.right.mas_equalTo(leftView.mas_right).offset(-40);
        make.width.mas_equalTo(@20);
    }];
    
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectZero];
    [headView addSubview:rightView];
    
    self.typeLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:14] textColor:RGB(106, 106, 106) textAlignment:NSTextAlignmentCenter];
    self.typeLabel.text = typeDefaultString;
    [rightView addSubview:self.typeLabel];
    
    UIImageView *rightArrowImage = [GQUIControl imageViewContentModel:UIViewContentModeScaleAspectFit];
    rightArrowImage.image = [UIImage imageNamed:@"arrow_down"];
    [rightView addSubview:rightArrowImage];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headView.mas_right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH / 2.0, 50));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightView.mas_centerY);
        make.left.mas_equalTo(rightView.mas_left).offset(40);
        make.right.mas_equalTo(rightArrowImage.mas_left).offset(-5);
    }];
    
    [rightArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rightView.mas_centerY);
        make.left.mas_equalTo(self.typeLabel.mas_right).offset(5);
        make.width.mas_equalTo(@20);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 11, 1, 28)];
    
    lineView.backgroundColor = RGBA(106, 106, 106,0.5);
    [rightView addSubview:lineView];
    
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSort:)];
    leftView.tag = sortByDefault;
    [leftView addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeSort:)];
    rightView.tag = sortByAmount;
    [rightView addGestureRecognizer:rightTap];
}

@end
