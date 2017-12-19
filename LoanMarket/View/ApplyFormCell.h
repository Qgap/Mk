//
//  ApplyFormCell.h
//  LoanMarket
//
//  Created by gap on 2017/11/27.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplyViewController;

UIKIT_EXTERN NSString *const kDismissKeyboard;

@interface ApplyFormCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UITextField *inputText;

@property (nonatomic, strong)UITextField *selectionText;

@property (nonatomic, strong)UIImageView *arrowImage;

@property (nonatomic, strong)UIView *genderView;

@property (nonatomic, strong)UIButton *manBtn;

@property (nonatomic, strong)UIButton *womanBtn;

- (void)setupCell:(NSArray *)dataArray indexPath:(NSIndexPath *)indexPath view:(UIView *)superView;

- (ApplyViewController *)applyViewController;

@end
