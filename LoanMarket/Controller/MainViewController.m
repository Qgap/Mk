//
//  MainViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "MainViewController.h"
//#import "HomeViewController.h"
//#import "LoanViewController.h"
//#import "ApplyViewController.h"
//#import "MineViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x5bd8ca)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f],
                                                        NSForegroundColorAttributeName : UIColorFromRGB(0x05b5f1)
                                                        } forState:UIControlStateSelected];
    
    NSArray *titleArray = @[@"首页",@"贷款",@"申请",@"我的"];
    NSArray *normalImage = @[@"home_normal",@"loan_normal",@"apply_normal",@"mine_normal"];
    NSArray *selectImage = @[@"home_select",@"loan_select",@"apply_select",@"mine_select"];
    
    NSArray *vcName = @[@"HomeViewController",
                        @"LoanViewController",
                        @"ApplyViewController",
                        @"MineViewController"];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:4];
    
    for ( int i = 0; i < titleArray.count; i++) {
        UINavigationController *nav = [self viewController:NSClassFromString(vcName[i])
                                                     title:titleArray[i]
                                               normalImage:normalImage[i]
                                               selectImage:selectImage[i]
                                                       tag:i];
        [viewControllers addObject:nav];
        
        
    }
    
    self.viewControllers = viewControllers;
    
    
}

- (UINavigationController *)viewController:(Class)vc
                                     title:(NSString *)title
                               normalImage:(NSString *)normalImage
                               selectImage:(NSString *)selectImage
                                       tag:(NSInteger)tag {
    
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[[vc class] alloc] init]];
    nav.tabBarItem.title = title;
    nav.tabBarItem.tag = tag;
    nav.tabBarItem.image = [[UIImage imageNamed:normalImage]
                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]
                                    imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return nav;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
