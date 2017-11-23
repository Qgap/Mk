//
//  LoginViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <Masonry.h>
#import "GQUIControl.h"
#import "PwdTextView.h"

@interface LoginViewController ()

@property (nonatomic, strong)UIScrollView *contentScroll;

@property (nonatomic, strong)UIView *passwdView;
@property (nonatomic, strong)UIView *codeView;
@property (nonatomic, strong)UIButton *pwdLogin;
@property (nonatomic, strong)UIButton *codeLogin;
@property (nonatomic, strong)UIView *slideView;

//@property (nonatomic, strong)UITextField *phoneText;
//@property (nonatomic, strong)UITextField *pwdText;
//@property (nonatomic, strong)UIButton *forgetBtn;
//@property (nonatomic, strong)UIButton *loginBtn;

@property (nonatomic, strong)UITextField *codePhoneText;
@property (nonatomic, strong)UITextField *codeText;
@property (nonatomic, strong)UIButton *getCodeBtn;
@property (nonatomic, strong)UIButton *codeLoginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *registerItem = [[UIBarButtonItem alloc] initWithTitle:@"注册"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(registerAction)];
    self.navigationItem.rightBarButtonItem = registerItem;
    
    [self setUpView];
}

- (void)registerAction {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)setUpView {
     self.pwdLogin = [GQUIControl buttonWithTitle:@"密码登录"
                                           titleColor:blackColor
                                             textFont:[UIFont systemFontOfSize:16]];
    
    [self.pwdLogin addTarget:self action:@selector(pwdLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pwdLogin];
    
    self.codeLogin = [GQUIControl buttonWithTitle:@"验证码登录"
                                           titleColor:blackColor
                                             textFont:[UIFont systemFontOfSize:16]];
    
    [self.codeLogin addTarget:self action:@selector(codeLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.codeLogin];
    
    self.slideView = [[UIView alloc] init];
    self.slideView.backgroundColor = themeColor;
    [self.view addSubview:self.slideView];
    
    [self.pwdLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@45);
        make.left.mas_equalTo(self.view.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH / 2.0);
    }];
    
    [self.codeLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@45);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH / 2.0);
    }];
  
    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdLogin.mas_bottom).offset(3);
        make.width.mas_equalTo(110*WIDTH_SCALE);
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(self.pwdLogin.mas_centerX);
    }];
  
    self.contentScroll = [GQUIControl scrollViewWithFrame:CGRectZero
                                              contentSize:CGSizeMake(SCREEN_WIDTH * 2, 0)
                                                  showVer:NO
                                                  showHor:NO
                                                 delegate:self
                             IStranslatesAutoresizingMask:YES];
    [self.view addSubview:self.contentScroll];
    
    [self.contentScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.pwdLogin.mas_bottom).offset(15);
    }];
    
    self.passwdView = [[UIView alloc] init];
    [self.contentScroll addSubview:self.passwdView];
    
    self.codeView = [[UIView alloc] init];
    [self.contentScroll addSubview:self.codeView];
    
    [self.passwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentScroll.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentScroll.mas_top);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.left.mas_equalTo(self.contentScroll.mas_left).offset(SCREEN_WIDTH);
    }];
    
    self.codeView.backgroundColor = [UIColor whiteColor];
    self.passwdView.backgroundColor = [UIColor whiteColor];
    
    PwdTextView *pwdView = [[PwdTextView alloc] init];
    [self.passwdView addSubview:pwdView];
    [pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.top.mas_offset(make.)
    }];
    
    // left
    
//    self.phoneText = [GQUIControl textFieldWithPlaceHolder:@"请输入您的手机号"
//                                                  textFont:[UIFont systemFontOfSize:13]
//                                                 textColor:grayColor
//                                             textAlignment:NSTextAlignmentLeft];
//    self.phoneText.backgroundColor = UIColorFromRGB(0xf3f3f3);
//    self.phoneText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
//    self.phoneText.layer.borderWidth = 1;
//    self.phoneText.layer.cornerRadius = 5;
//    [self.passwdView addSubview:self.phoneText];
//    
//    self.pwdText = [GQUIControl textFieldWithPlaceHolder:@"请输入密码"
//                                                textFont:[UIFont systemFontOfSize:13]
//                                               textColor:grayColor
//                                           textAlignment:NSTextAlignmentLeft];
//    self.pwdText.backgroundColor = UIColorFromRGB(0xf3f3f3);
//    self.pwdText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
//    self.pwdText.layer.cornerRadius = 5;
//    self.pwdText.layer.borderWidth = 1;
//    [self.passwdView addSubview:self.pwdText];
//    
//    self.forgetBtn = [GQUIControl buttonWithTitle:@"忘记密码"
//                                       titleColor:orangeColor
//                                         textFont:[UIFont systemFontOfSize:12]];
//    [self.forgetBtn addTarget:self
//                       action:@selector(forgetPwd)
//             forControlEvents:UIControlEventTouchUpInside];
//    [self.passwdView addSubview:self.forgetBtn];
//    
//    self.loginBtn = [GQUIControl buttonWithTitle:@"登录"
//                                      titleColor:[UIColor whiteColor]
//                                        textFont:[UIFont systemFontOfSize:16]];
//    self.loginBtn.backgroundColor = orangeColor;
//    self.loginBtn.layer.cornerRadius = 5;
//    [self.loginBtn addTarget:self
//                      action:@selector(login)
//            forControlEvents:UIControlEventTouchUpInside];
//    [self.passwdView addSubview:self.loginBtn];
//    
//    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.mas_equalTo(self.passwdView.mas_top).offset(10);
//        make.right.mas_equalTo(self.passwdView.mas_right).offset(-37*WIDTH_SCALE);
//        make.left.mas_equalTo(self.passwdView.mas_left).offset(37*WIDTH_SCALE);
//        make.height.mas_equalTo(40);
//    }];
//    
//    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(20);
//        make.right.mas_equalTo(self.passwdView.mas_right).offset(-37*WIDTH_SCALE);
//        make.left.mas_equalTo(self.passwdView.mas_left).offset(37*WIDTH_SCALE);
//        make.height.mas_equalTo(40);
//    }];
//    
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
    
 // ----
    
    self.codePhoneText = [GQUIControl textFieldWithPlaceHolder:@"请输入您的手机号"
                                                  textFont:[UIFont systemFontOfSize:13]
                                                 textColor:grayColor
                                             textAlignment:NSTextAlignmentLeft];
    self.codePhoneText.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.codePhoneText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    self.codePhoneText.layer.borderWidth = 1;
    self.codePhoneText.layer.cornerRadius = 5;
    [self.codeView addSubview:self.codePhoneText];
    
    self.codeText = [GQUIControl textFieldWithPlaceHolder:@"请输入验证码"
                                                textFont:[UIFont systemFontOfSize:13]
                                               textColor:grayColor
                                           textAlignment:NSTextAlignmentLeft];
    self.codeText.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.codeText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    self.codeText.layer.cornerRadius = 5;
    self.codeText.layer.borderWidth = 1;
    [self.codeView addSubview:self.codeText];
    
    self.getCodeBtn = [GQUIControl buttonWithTitle:@"获取验证码"
                                       titleColor:orangeColor
                                         textFont:[UIFont systemFontOfSize:12]];
    [self.getCodeBtn addTarget:self
                       action:@selector(getCode)
             forControlEvents:UIControlEventTouchUpInside];
    [self.codeView addSubview:self.getCodeBtn];
    
    self.codeLoginBtn = [GQUIControl buttonWithTitle:@"立即登录"
                                      titleColor:[UIColor whiteColor]
                                        textFont:[UIFont systemFontOfSize:16]];
    self.codeLoginBtn.backgroundColor = orangeColor;
    self.codeLoginBtn.layer.cornerRadius = 5;
    [self.codeLoginBtn addTarget:self
                      action:@selector(login)
            forControlEvents:UIControlEventTouchUpInside];
    [self.codeView addSubview:self.codeLoginBtn];
    
    [self.codePhoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.codeView.mas_top).offset(10);
        make.right.mas_equalTo(self.codeView.mas_right).offset(-37*WIDTH_SCALE);
        make.left.mas_equalTo(self.codeView.mas_left).offset(37*WIDTH_SCALE);
        make.height.mas_equalTo(40);
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codePhoneText.mas_bottom).offset(20);
        make.right.mas_equalTo(self.codePhoneText.mas_right);
        make.width.mas_equalTo(98*WIDTH_SCALE);
    }];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codePhoneText.mas_bottom).offset(20);
        make.right.mas_equalTo(self.getCodeBtn.mas_left).offset(-21*WIDTH_SCALE);
        make.left.mas_equalTo(self.codeView.mas_left).offset(37*WIDTH_SCALE);
        make.height.mas_equalTo(40);
    }];
    
    
    [self.codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeText.mas_bottom).offset(30);
        make.right.left.mas_equalTo(self.codePhoneText);
        make.height.mas_equalTo(40);
    }];
    
}

- (void)forgetPwd {
    NSLog(@"forget pwd ");
}

- (void)login {
    NSLog(@"login ");
}

- (void)pwdLoginAction {
//    [self.contentScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.contentScroll scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:YES];
}

- (void)codeLoginAction {
//    [self.contentScroll setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    [self.contentScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, 0, 0) animated:YES];

}

- (void)getCode {
    
}

@end
