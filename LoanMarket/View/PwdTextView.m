//
//  PwdView.m
//  LoanMarket
//
//  Created by gap on 2017/11/23.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "PwdTextView.h"
#import "GQUIControl.h"
#import <Masonry.h>

@interface PwdTextView ()

@property (nonatomic, strong)UITextField *phoneText;
@property (nonatomic, strong)UITextField *pwdText;
@property (nonatomic, strong)UIButton *forgetBtn;
@property (nonatomic, strong)UIButton *loginBtn;

@end

@implementation PwdTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.phoneText = [GQUIControl textFieldWithPlaceHolder:@"请输入您的手机号"
                                                  textFont:[UIFont systemFontOfSize:13]
                                                 textColor:grayColor
                                             textAlignment:NSTextAlignmentLeft];
    self.phoneText.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.phoneText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    self.phoneText.layer.borderWidth = 1;
    self.phoneText.layer.cornerRadius = 5;
    [self addSubview:self.phoneText];
    
    
    self.pwdText = [GQUIControl textFieldWithPlaceHolder:@"请输入密码"
                                                textFont:[UIFont systemFontOfSize:13]
                                               textColor:grayColor
                                           textAlignment:NSTextAlignmentLeft];
    self.pwdText.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.pwdText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    self.pwdText.layer.cornerRadius = 5;
    self.pwdText.layer.borderWidth = 1;
    [self addSubview:self.pwdText];
    
//    self.forgetBtn = [GQUIControl buttonWithTitle:@"忘记密码"
//                                       titleColor:orangeColor
//                                         textFont:[UIFont systemFontOfSize:12]];
//    [self.forgetBtn addTarget:self
//                       action:@selector(forgetPwd)
//             forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.forgetBtn];
//
//    self.loginBtn = [GQUIControl buttonWithTitle:@"登录"
//                                      titleColor:[UIColor whiteColor]
//                                        textFont:[UIFont systemFontOfSize:16]];
//    self.loginBtn.backgroundColor = orangeColor;
//    self.loginBtn.layer.cornerRadius = 5;
//    [self.loginBtn addTarget:self
//                      action:@selector(login)
//            forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.loginBtn];
//
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-37*WIDTH_SCALE);
        make.left.mas_equalTo(self.mas_left).offset(37*WIDTH_SCALE);
        make.height.mas_equalTo(40);
    }];
    
    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(20);
        make.right.mas_equalTo(self.mas_right).offset(-37*WIDTH_SCALE);
        make.left.mas_equalTo(self.mas_left).offset(37*WIDTH_SCALE);
        make.height.mas_equalTo(40);
    }];
    
//    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.pwdText.mas_bottom).offset(20);
//        make.right.mas_equalTo(self.phoneText.mas_right);
//    }];
//
//    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.forgetBtn.mas_bottom).offset(20);
//        make.right.left.mas_equalTo(self.phoneText);
//        make.height.mas_equalTo(40);
//    }];
}

@end
