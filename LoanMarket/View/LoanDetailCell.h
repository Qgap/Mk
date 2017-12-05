//
//  LoanDetailCell.h
//  LoanMarket
//
//  Created by gap on 2017/12/3.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanDetailCell : UITableViewCell

@end

@interface LabelView : UIView

- (void)setupContent:(NSString *)content title:(NSString *)title rightLayerHidden:(BOOL)hidden;

@end
