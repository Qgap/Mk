//
//  ApplyViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "ApplyViewController.h"
#import "SectionHeadView.h"
#import "ApplyFormCell.h"

typedef NS_ENUM(NSInteger,SelectType) {
    TextField,
    Selector,
    BooleanCheck
};

@interface ApplyViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)UIView *footerView;

@property (nonatomic, strong)NSMutableArray *resultDataArray;

@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"助贷申请";
    
    self.dataArray = @[@{@"title":@"姓名",@"type":@"TextField",@"placeHolder":@"请输入您的姓名"},
                       @{@"title":@"手机号",@"type":@"TextField",@"placeHolder":@"请输入您的11位手机号"},
                       @{@"title":@"贷款金额",@"type":@"TextField",@"placeHolder":@"请输入您想要申请的金额"},
                       @{@"title":@"期望期限",@"type":@"Selector",@"placeHolder":@"请选择贷款期限"},
                       @{@"title":@"职业身份",@"type":@"Selector",@"placeHolder":@"请选择职业类别"},
                       @{@"title":@"所在城市",@"type":@"Selector",@"placeHolder":@"请选择居住城市"},
                       @{@"title":@"性别",@"type":@"booleanCheck",@"placeHolder":@""},
                       @{@"title":@"信用卡数量",@"type":@"Selector",@"placeHolder":@"请输入信用卡数量"},
                       @{@"title":@"号码使用时间",@"type":@"Selector",@"placeHolder":@"请选择使用时间"}
                       ];
    
    self.resultDataArray = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<self.dataArray.count; i++) {
        [self.resultDataArray addObject:@""];
    }
    [self.view addSubview:self.tableView];
}

- (void)applyAction {
    for (int i = 0; i< self.dataArray.count; i ++ ) {
        ApplyFormCell *cell = (ApplyFormCell *)[self.tableView viewWithTag:200 + i];
        
        if (i < 3) {
            self.resultDataArray[i] = cell.inputText.text;
        } else if (i == 6) {
            if (cell.manBtn.selected) {
                self.resultDataArray[i] = @"男";
            } else {
                self.resultDataArray[i] = @"女";
            }
        } else {
            self.resultDataArray[i] = cell.selectionText.text;
        }
    }
    
    NSLog(@"array :%@",self.resultDataArray);
}

#pragma mark - UITableView

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        _tableView.estimatedRowHeight = 0.f;
        [_tableView registerClass:[ApplyFormCell class] forCellReuseIdentifier:@"CellId"];
        
        self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
        self.footerView.backgroundColor = [UIColor whiteColor];
        UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [applyBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        applyBtn.backgroundColor = orangeColor;
        applyBtn.frame = CGRectMake(60, 25, SCREEN_WIDTH - 120, 45);
        applyBtn.layer.cornerRadius = 5;
        [applyBtn addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:applyBtn];
        _tableView.tableFooterView = self.footerView;
    }
    
    return _tableView;
}


#pragma mark - UITableViewDelegate && DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    ApplyFormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    cell.tag = 200 + indexPath.row;
    
    [cell setupCell:self.dataArray indexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SectionHeadView *view = [[SectionHeadView alloc] init];
    
    view.titleLabel.text = @"助贷申请";
    
    return view;
}

@end
