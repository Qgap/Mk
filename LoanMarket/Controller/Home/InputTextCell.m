//
//  InputTextCell.m
//  LoanMarket
//
//  Created by gap on 2017/11/23.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "InputTextCell.h"
#import "GQUIControl.h"
#import <Masonry.h>

@interface InputTextCell ()
@property (nonatomic, strong)UITextField *textField;
@end

@implementation InputTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textField = [GQUIControl textFieldWithPlaceHolder:@"请输入您的手机号"
                                                      textFont:[UIFont systemFontOfSize:13]
                                                     textColor:grayColor
                                                 textAlignment:NSTextAlignmentLeft];
        self.textField.backgroundColor = UIColorFromRGB(0xf3f3f3);
        self.textField.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
        self.textField.layer.borderWidth = 1;
        self.textField.layer.cornerRadius = 5;
        [self.contentView addSubview:self.textField];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return self;
}

@end



