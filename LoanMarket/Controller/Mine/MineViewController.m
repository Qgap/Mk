//
//  MineViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "MineViewController.h"
#import "GQUIControl.h"
#import <Masonry.h>
#import "DataCenter.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "WKWebViewController.h"
#import "UIImage+Category.h"
#import "Request.h"
#import "UserInfoModel.h"
#import <UIImageView+WebCache.h>

static NSString *const cellId = @"CELLID";

static CGFloat headHeight = 278;

@interface MineViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIImageView *bgImageView;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, strong)UIView *headView;

@property (nonatomic, strong)UIImageView *headBgImage;

@property (nonatomic, strong)UIImageView *avatarImage;

@property (nonatomic, strong)UIButton *loginBtn;

@property (nonatomic, strong)UIButton *regBtn;

@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UILabel *phoneLabel;

@property (nonatomic,strong) UserInfoModel *userModel;

//@property (nonatomic, strong)UIButton *loginOutBtn;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人中心";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    self.dataArray = @[@[@{@"image":@"card_mine",@"title":@"我要办卡",actionName:kBank},
//                       @{@"image":@"loan_mine",@"title":@"我要贷款",actionName:kLoan},
//                       @{@"image":@"raise_mine",@"title":@"我要提额",actionName:kRaiseAmount}],
//                       @[@{@"image":@"guide_mine",@"title":@"新手指南",actionName:kGuide},
//                         @{@"image":@"service_mine",@"title":@"我的客服",actionName:kService}]
//                       ];

    
    self.dataArray = @[@[@{@"image":@"card_mine",@"title":@"我要办卡",actionName:kBank},
                         @{@"image":@"loan_mine",@"title":@"我要贷款",actionName:kLoan}
                         ],
                       @[
                         @{@"image":@"service_mine",@"title":@"关于我们",actionName:kAbountUs}]
                       ];

    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [Request postURL:userInfoURL params:nil completion:^(BOOL success, id responseObject, NSError *error) {
        if (success) {
            self.userModel = [UserInfoModel yy_modelWithDictionary:responseObject[@"data"]];
            
            dispatch_main_sync_safe(^{
                self.nameLabel.text = nullStr(self.userModel.userName, @"");
                self.phoneLabel.text = nullStr(self.userModel.phoneNo, @"");
                [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:self.userModel.iconUrl] placeholderImage:[UIImage imageNamed:@"help_center"]];
            });
        }
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:themeColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headHeight)];
        self.headBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , headHeight)];
        self.headBgImage.backgroundColor = themeColor;
        self.headBgImage.clipsToBounds = YES;
        self.headBgImage.contentMode = UIViewContentModeScaleAspectFill;
        
        self.avatarImage = [[UIImageView alloc] init];
        self.avatarImage.image = [UIImage imageNamed:@"help_center"];
        self.avatarImage.layer.cornerRadius = 47;
        self.avatarImage.layer.masksToBounds = YES;
        
        self.nameLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:16]
                                              textColor:[UIColor whiteColor]
                                          textAlignment:NSTextAlignmentLeft];
        
        self.phoneLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:16]
                                               textColor:[UIColor whiteColor]
                                           textAlignment:NSTextAlignmentLeft];
        
        [self.headBgImage addSubview:self.nameLabel];
        [self.headBgImage addSubview:self.phoneLabel];
        [self.headBgImage addSubview:self.avatarImage];
        [self.headView addSubview:self.headBgImage];
        self.tableView.tableHeaderView = self.headView;
        
        [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headBgImage.mas_bottom).offset(-35);
            make.left.mas_equalTo(self.headBgImage.mas_left).offset(30);
            make.size.mas_equalTo(CGSizeMake(94, 94));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImage.mas_right).offset(30);
            make.top.mas_equalTo(self.avatarImage.mas_top).offset(15);
        }];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        }];
        
        self.nameLabel.text = @"hello";
        
        self.phoneLabel.text = @"124442";
        
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        footerView.backgroundColor = [UIColor clearColor];
        
        UIButton *signOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [signOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        signOutBtn.backgroundColor = orangeColor;
        signOutBtn.layer.cornerRadius = 5;
        [signOutBtn addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:signOutBtn];
        
        _tableView.tableFooterView = footerView;
        
        [signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(footerView.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100 * WIDTH_SCALE, 44));
            make.centerX.mas_equalTo(footerView.mas_centerX);
        }];
    }
    return _tableView;
}

- (void)signOut {
    [[DataCenter sharedInstance] loginOutSuccessed];
    
    UINavigationController *loginVC = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.y < 0) {
        CGRect rect = self.headBgImage.frame;
        rect.origin.y = offset.y;
        rect.size.height = headHeight - offset.y;
        self.headBgImage.frame = rect;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                            forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.section][indexPath.row][@"image"]];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row][@"title"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *action = self.dataArray[indexPath.section][indexPath.row][actionName];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([action isEqualToString:kLoan]) {
        
        appdelegate.mainVC.selectedIndex = 1;
        
    } else if ([action isEqualToString:kBank]) {
        appdelegate.mainVC.selectedIndex = 2;
    } else if ([action isEqualToString:kAbountUs]) {
        WKWebViewController *vc = [[WKWebViewController alloc] initWithUrl:aboutUsHTML];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
