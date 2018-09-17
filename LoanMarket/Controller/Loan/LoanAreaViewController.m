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
#import "LoanAreaCell.h"

static NSString *const firstCell = @"FIRSTCELL";
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
    self.navigationItem.title = @"贷款专区";
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionTitleArray = @[@"",@"申请条件",@"申请资料",@"审核及还款说明"];
    self.conditionArray = @[@[],
                            @[@"年龄20 -40 岁",@"手机号使用6个月以上",@"芝麻分500以上"],
                            @[@"身份证",@"手机号",@"芝麻分"],
                            @[@"芝麻分500以上，验证身份证及手机号通过率100%"]];
    [self.view addSubview:self.tableView];
    
    [self initUI];
}

- (void)initUI {
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 75, SCREEN_WIDTH, 75)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyButton.frame = CGRectMake(60 * WIDTH_SCALE, 15 , SCREEN_WIDTH - 120 * WIDTH_SCALE, 45);
    [self.applyButton setTitle:@"申请贷款" forState:UIControlStateNormal];
    [self.applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.applyButton addTarget:self action:@selector(applyLoan) forControlEvents:UIControlEventTouchUpInside];
    self.applyButton.backgroundColor = orangeColor;
    self.applyButton.layer.cornerRadius = 5;
    self.applyButton.titleLabel.font = Font18;
    [self.bottomView addSubview:self.applyButton];
}

- (void)applyLoan {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            LoanAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
            
            return cell;
        } else {
            LoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else {
        ConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:conditionCell forIndexPath:indexPath];
        cell.titleLabel.text = self.conditionArray[indexPath.section][indexPath.row];
        
        return cell;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return [self.conditionArray[section] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray *heightArray = @[@"82",@"60",@"42",@"130"];
        
        return [heightArray[indexPath.row] integerValue] * WIDTH_SCALE;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 75) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[LoanAreaCell class] forCellReuseIdentifier:firstCell];
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
