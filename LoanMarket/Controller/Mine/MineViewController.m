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

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.dataArray = @[@{@"image":@"person_info",@"title":@"个人信息修改"},
                       @{@"image":@"help_center",@"title":@"帮助中心"},
                       @{@"image":@"business",@"title":@"商务合作"},
                       @{@"image":@"setting",@"title":@"设置"}];
    
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 20;
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
    }
    return _tableView;
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
    
    cell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.row][@"image"]];
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
