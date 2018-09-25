//
//  ApplyCardViewController.m
//  LoanMarket
//
//  Created by gap on 2018/9/16.
//  Copyright © 2018年 gq. All rights reserved.
//

#import "ApplyCardViewController.h"
#import "ApplyCardCell.h"
#import "CardListModel.h"
#import "Request.h"
#import "WKWebViewController.h"

static NSString *const cellId = @"CardListCell";

@interface ApplyCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation ApplyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"办卡";
//    self.dataArray = [NSMutableArray arrayWithCapacity:10];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadRequest];
}

- (void)loadRequest {
    [SVProgressHUD show];
    [Request postURL:bankList params:nil completion:^(BOOL success, id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (success) {

            self.dataArray = [NSArray yy_modelArrayWithClass:[CardListModel class] json:responseObject[@"data"]];
            
            [self.tableView reloadData];
        }
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ApplyCardCell class] forCellReuseIdentifier:cellId];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplyCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    [cell configureCell:self.dataArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100 * WIDTH_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CardListModel *model = self.dataArray[indexPath.row];
    WKWebViewController *vc = [[WKWebViewController alloc] initWithUrl:model.bankUrl];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
