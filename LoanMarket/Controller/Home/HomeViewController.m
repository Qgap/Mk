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
#import "AunounceCell.h"
#import "SectionHeadView.h"

static NSString *AnuounceCell = @"AUNOUNCE";
static NSString *HotLoanCell = @"HOTLOAN";
static NSString *RecommendCell = @"RECOMMEND";


@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)AdvertisingColumn *adView; 
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSArray *sectionRowArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"乐贷超市";
    
    self.dataArray = [NSMutableArray arrayWithCapacity:10];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedSectionFooterHeight = 0.f;
    self.tableView.estimatedSectionHeaderHeight = 30;
    [self.tableView registerClass:[HomeLoanCell class] forCellReuseIdentifier:HotLoanCell];
    [self.tableView registerClass:[AunounceCell class] forCellReuseIdentifier:AnuounceCell];
    [self.tableView registerClass:[HotRecommendCell class] forCellReuseIdentifier:RecommendCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    self.adView = [[AdvertisingColumn alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    [self.adView setArray:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"]];
    
    WS(weakSelf, self);
    self.adView.adImageClick = ^(UITapGestureRecognizer *tap) {
        [weakSelf adImageClick:tap];
    };
    
    self.tableView.tableHeaderView = self.adView;
    
}

- (void)adImageClick:(UITapGestureRecognizer *)sender {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        AunounceCell *cell = [tableView dequeueReusableCellWithIdentifier:AnuounceCell forIndexPath:indexPath];
        [cell setupAunounceScroll:@[@"上善若水",@"恭喜高青中奖500万",@"17620362405",@"人有善念，天必佑之"]];
        return cell;
    } else if (indexPath.section == 1) {
        HotRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        HomeLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:HotLoanCell forIndexPath:indexPath];
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 20;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeadView *view = [[SectionHeadView alloc] init];
    view.titleLabel.text = @"热门贷款";
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1){
        return 125 * WIDTH_SCALE;
    } else {
        return 90;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
