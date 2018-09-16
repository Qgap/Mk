//
//  HomeCell.h
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HomeLoanCell : UITableViewCell

@end

@interface HotRecommendCell : UITableViewCell

@end

typedef void(^loanTypeClick)(UIButton *);

@interface LoanTypeCell : UITableViewCell

@property (nonatomic,copy)loanTypeClick loanTypeButton;

@end

@interface FunctionAreaCell : UITableViewCell

@end
