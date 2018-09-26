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
#import "Request.h"
#import "ProductDetailModel.h"
#import "NSString+AttributeString.h"
#import "WKWebViewController.h"

static NSString *const firstCell = @"FIRSTCELL";
static NSString *const detailCell = @"DetailCell";
static NSString *const guideCell = @"GuideCell";
static NSString *const conditionCell = @"ConditionCell";

@interface LoanAreaViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIButton *applyButton;
@property (nonatomic, strong)ProductDetailModel *model;
@property (nonatomic, copy)NSString *productID;
@end

@implementation LoanAreaViewController

- (id)initWithProductID:(NSString *)productID {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.productID = productID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"贷款专区";
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadRequest];
}

- (void)loadRequest {
    
    [SVProgressHUD show];
    [Request postURL:productById params:@{@"productId":self.productID} completion:^(BOOL success, id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (success) {
//            NSLog(@"response :%@",responseObject);
            self.model = [ProductDetailModel yy_modelWithDictionary:responseObject[@"data"]];
            [self.tableView reloadData];
        }
    }];
}

- (void)applyLoan {
    
    [Request postURL:trafficURL params:@{@"productId":self.model.productId,@"type":@"1"} completion:^(BOOL success, id responseObject, NSError *error) {
        
    }];
    
    if (self.model.applyUrl) {
        WKWebViewController *vc = [[WKWebViewController alloc] initWithUrl:self.model.applyUrl];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            LoanAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell];
            [cell configureCell:self.model];
            return cell;
        } else if (indexPath.row == 1) {
            LoanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell configureCell:self.model];
            
            return cell;
        } else {
            GuideConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:guideCell];
            
            return cell;
        }
    } else {
        ConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:conditionCell forIndexPath:indexPath];
        cell.titleLabel.attributedText = [NSString setTextLineSpace:5 withString:self.model.applyInfo[indexPath.row] withFont:14];
        return cell;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return self.model.applyInfo.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray *heightArray = @[@"82",@"102",@"130"];
        
        if (indexPath.row == 1) {
            CGFloat maxWidth = SCREEN_WIDTH - 40;
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
            
            CGSize size = [[NSString setTextLineSpace:5 withString:self.model.slogan withFont:14] boundingRectWithSize:CGSizeMake(maxWidth, 300) options:options context:nil].size;
            
            CGFloat height = size.height + 10;
            
            return height < 42 ? 102 : height + 70;
            
        } else {
            return [heightArray[indexPath.row] integerValue] * WIDTH_SCALE;
        }

        
    } else {
        
        CGFloat maxWidth = SCREEN_WIDTH - 40;
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin ;
        
        CGSize size = [[NSString setTextLineSpace:10 withString:self.model.applyInfo[indexPath.row] withFont:14] boundingRectWithSize:CGSizeMake(maxWidth, 300) options:options context:nil].size;
        
        CGFloat height = size.height + 10;
        
        return height < 35 ? 35 : height;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 44;
    }
    return 10;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        SectionHeadView *view = [[SectionHeadView alloc] init];
        view.titleLabel.text = @"申请事项";
        view.titleLabel.textColor = blackColor;
        return view;
    }
    return nil;
}

#pragma mark - UI Init

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[LoanAreaCell class] forCellReuseIdentifier:firstCell];
        [_tableView registerClass:[LoanDetailCell class] forCellReuseIdentifier:detailCell];
        [_tableView registerClass:[GuideConditionCell class] forCellReuseIdentifier:guideCell];
        [_tableView registerClass:[ConditionCell class] forCellReuseIdentifier:conditionCell];
    }
    return _tableView;
}

- (void)initUI {
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 75 - SafeAreaBottomHeight, SCREEN_WIDTH, 75)];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
