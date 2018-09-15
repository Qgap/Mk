//
//  ScrollAdView.h
//  LoanMarket
//
//  Created by gap on 2017/11/25.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;

@interface AunounceCell : UITableViewCell

@property (nonatomic, strong)HomeViewController *homeVC;

- (void)setupAunounceScroll:(NSArray *)array;

@end


