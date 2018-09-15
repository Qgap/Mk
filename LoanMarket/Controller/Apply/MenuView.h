//
//  MenuView.h
//  LoanMarket
//
//  Created by gap on 2017/12/19.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIView

@property (nonatomic, copy)void (^Selector)(NSString *text);

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)array;
@end
