//
//  LoanAreaViewController.m
//  LoanMarket
//
//  Created by gap on 2017/12/2.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "LoanAreaViewController.h"
#import "LoanDetailCell.h"
#import "SectionHeadView.h"

static NSString *const detailCell = @"DetailCell";
static NSString *const conditionCell = @"ConditionCell";

@interface LoanAreaViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *sectionTitleArray;
@property (nonatomic, strong)NSArray *conditionArray;

@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIButton *applyButton;
@end

@implementation LoanAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"贷款专区";
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionTitleArray = @[@"",@"申请条件",@"申请资料",@"审核及还款说明"];
    self.conditionArray = @[@[],
                            @[@"年龄20 -40 岁",@"手机号使用6个月以上",@"芝麻分500以上"],
                            @[@"身份证",@"手机号",@"芝麻分"],
                            @[@"芝麻分500以上，验证身份证及手机号通过率100%"]];
    [self.view addSubview:self.tableView];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
        LoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        ConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:conditionCell forIndexPath:indexPath];
        cell.titleLabel.text = self.conditionArray[indexPath.section][indexPath.row];
        
        return cell;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [self.conditionArray[section] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    } else
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 44;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        SectionHeadView *view = [[SectionHeadView alloc] init];
        view.titleLabel.text = self.sectionTitleArray[section];
        view.titleLabel.textColor = blackColor;
        return view;
    }
    return nil;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        [_tableView registerClass:[LoanDetailCell class] forCellReuseIdentifier:detailCell];
        [_tableView registerClass:[ConditionCell class] forCellReuseIdentifier:conditionCell];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
