//
//  HomeViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "HomeViewController.h"
#import "AdvertisingColumn.h"
#import "HomeLoanCell.h"

static NSString *HotLoan = @"HOTLOAN";
static NSString *Recommend = @"RECOMMEND";

@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)AdvertisingColumn *adView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"hello";
    
    self.dataArray = [NSMutableArray arrayWithCapacity:10];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[HomeLoanCell class] forCellReuseIdentifier:HotLoan];
    [self.view addSubview:self.tableView];
    
    self.adView = [[AdvertisingColumn alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    WS(weakSelf, self);
    self.adView.adImageClick = ^(UITapGestureRecognizer *tap) {
        [weakSelf adImageClick:tap];
    };
    
    self.tableView.tableHeaderView = self.adView;
}


- (void)adImageClick:(UITapGestureRecognizer *)sender {
    NSLog(@"tag :%d",sender.view.tag);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:HotLoan forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArray.count;
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
