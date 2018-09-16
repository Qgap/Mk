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
#import "LoanAreaViewController.h"

static NSString *AnuounceCell = @"AUNOUNCE";
static NSString *HotLoanCell = @"HOTLOAN";
//static NSString *RecommendCell = @"RECOMMEND";
static NSString *LoanTypeCellID = @"LOANTYPE";
static NSString *FunctionCell = @"FUNCTION";


typedef NS_ENUM(NSInteger,SectionType) {
    AunounceSection,
    LoanTypeSection,
    FunctionTypeSection,
    HotRecommendSection
};

@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)AdvertisingColumn *adView; 
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSArray *sectionRowArray;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"乐贷超市";
    
    self.dataArray = [NSMutableArray arrayWithCapacity:10];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedSectionFooterHeight = 0.f;
    self.tableView.estimatedSectionHeaderHeight = 10.f;
    [self.tableView registerClass:[HomeLoanCell class] forCellReuseIdentifier:HotLoanCell];
    [self.tableView registerClass:[AunounceCell class] forCellReuseIdentifier:AnuounceCell];
    [self.tableView registerClass:[LoanTypeCell class] forCellReuseIdentifier:LoanTypeCellID];
    [self.tableView registerClass:[FunctionAreaCell class] forCellReuseIdentifier:FunctionCell];
//    [self.tableView registerClass:[HotRecommendCell class] forCellReuseIdentifier:RecommendCell];
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
    
    if (indexPath.section == AunounceSection) {
        AunounceCell *cell = [tableView dequeueReusableCellWithIdentifier:AnuounceCell forIndexPath:indexPath];
        [cell setupAunounceScroll:@[@"上善若水",@"恭喜高青中奖500万",@"17620362405",@"人有善念，天必佑之"]];
        return cell;
    } else if (indexPath.section == LoanTypeSection) {
        
        LoanTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:LoanTypeCellID];
        cell.loanTypeButton = ^(UIButton *sender) {
            NSLog(@"button tag :%ld",sender.tag);
        };
        return cell;
        
//        HotRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendCell forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
    } else if (indexPath.section == FunctionTypeSection){
        FunctionAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:FunctionCell];
        
        return cell;
        
    } else {
        HomeLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:HotLoanCell forIndexPath:indexPath];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == HotRecommendSection) {
        return 20;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == HotRecommendSection) {
        SectionHeadView *view = [[SectionHeadView alloc] init];
        view.titleLabel.text = @"热门贷款";
        return view;
    }
    return nil;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if (section == HotRecommendSection) {
        return 44;
    }
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    } else if (indexPath.section == 1) {
        return 80 * WIDTH_SCALE;
    } else if (indexPath.section == FunctionTypeSection) {
        return 69 * WIDTH_SCALE;
    } else {
        return 90;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) return ;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LoanAreaViewController *loan = [[LoanAreaViewController alloc] init];
    loan.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loan animated:YES];
    
}

@end
