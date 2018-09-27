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
#import "Request.h"
#import "ProductModel.h"
#import "Appdelegate.h"


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
@property (nonatomic, strong)NSArray *productArray;
@property (nonatomic, strong)NSArray *noticeArray;
@property (nonatomic, strong)NSArray *bannerArray;
@property (nonatomic, strong)NSArray <BannerModel *> *bannerModelArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"花钱666";
    
    self.dataArray = [NSMutableArray arrayWithCapacity:10];
    
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self loadRequest];
    
}

#pragma mark - Load Data

- (void)loadRequest {
    [SVProgressHUD show];
    
    [Request postURL:bannaerURL params:nil completion:^(BOOL success, id responseObject, NSError *error) {
         NSLog(@"banner :%@",responseObject);
        if (success) {
            
            self.bannerModelArray = [NSArray yy_modelArrayWithClass:[BannerModel class] json:responseObject[@"data"]];
            
            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:10];
            for (BannerModel *model in self.bannerModelArray) {
                [mutableArray addObject:model.imgUrl];
            }
            
            self.bannerArray = mutableArray;
            
            dispatch_main_sync_safe(^{
                [self.adView setArray:self.bannerArray];
            });
        }
    }];
    
    [Request postURL:noticeURL params:nil completion:^(BOOL success, id responseObject, NSError *error) {
        NSLog(@"response :%@",responseObject);
        if (success) {
            
            NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:10];
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                [mutableArray addObject:dic[@"noticeContext"]];
                
            }
            
            self.noticeArray = mutableArray;
            [self.tableView reloadData];
        }
    }];
    
    
    [Request postURL:productTypeList params:@{@"showType":@"1"} completion:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            [SVProgressHUD dismiss];
            
            self.productArray = [NSArray yy_modelArrayWithClass:[ProductModel class] json:responseObject[@"data"]];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showInfoWithStatus:error.domain];
        }
    }];
}

#pragma mark - UITapGestureRecognizer Action

- (void)adImageClick:(UITapGestureRecognizer *)sender {
    NSInteger tag = sender.view.tag - baseTapTag;
    BannerModel *model = self.bannerModelArray[tag];
    LoanAreaViewController *vc = [[LoanAreaViewController alloc] initWithProductID:model.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == AunounceSection) {
        AunounceCell *cell = [tableView dequeueReusableCellWithIdentifier:AnuounceCell forIndexPath:indexPath];
//        [cell setupAunounceScroll:@[@"上善若水",@"恭喜高青中奖500万",@"17620362405",@"人有善念，天必佑之"]];
        [cell setupAunounceScroll:self.noticeArray];
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
        [cell configureCell:self.productArray[indexPath.row]];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == HotRecommendSection) {
        return self.productArray.count;
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


-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == HotRecommendSection) {
        return 44;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {

    if (section == FunctionTypeSection) {
        return 10;
    }

    return 0.01f;
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
    
    ProductModel *model = self.productArray[indexPath.row];
    
    LoanAreaViewController *loan = [[LoanAreaViewController alloc] initWithProductID:model.priductId];
    loan.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loan animated:YES];
    
}

#pragma mark - UI init

- (void)initUI {
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight - 49) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    [self.tableView registerClass:[HomeLoanCell class] forCellReuseIdentifier:HotLoanCell];
    [self.tableView registerClass:[AunounceCell class] forCellReuseIdentifier:AnuounceCell];
    [self.tableView registerClass:[LoanTypeCell class] forCellReuseIdentifier:LoanTypeCellID];
    [self.tableView registerClass:[FunctionAreaCell class] forCellReuseIdentifier:FunctionCell];
    //    [self.tableView registerClass:[HotRecommendCell class] forCellReuseIdentifier:RecommendCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    self.adView = [[AdvertisingColumn alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
//    [self.adView setArray:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"]];
    
    WS(weakSelf, self);
    self.adView.adImageClick = ^(UITapGestureRecognizer *tap) {
        [weakSelf adImageClick:tap];
    };
    
    self.tableView.tableHeaderView = self.adView;
}

@end
