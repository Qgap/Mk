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
#import "Request.h"
#import "DataCenter.h"


@interface LoginViewController ()

//@property (nonatomic, strong)UIScrollView *contentScroll;

@property (nonatomic, strong)UIView *passwdView;
@property (nonatomic, strong)UIView *codeView;
@property (nonatomic, strong)UIButton *pwdLogin;
@property (nonatomic, strong)UIButton *codeLogin;
@property (nonatomic, strong)UIView *slideView;

@property (nonatomic, strong)UITextField *phoneText;
@property (nonatomic, strong)UITextField *pwdText;
@property (nonatomic, strong)UIButton *forgetBtn;
@property (nonatomic, strong)UIButton *loginBtn;

@property (nonatomic, strong)UITextField *codePhoneText;
@property (nonatomic, strong)UITextField *codeText;
@property (nonatomic, strong)UIButton *getCodeBtn;
@property (nonatomic, strong)UIButton *codeLoginBtn;

@property (nonatomic, assign)NSInteger timeInterval;// 倒计时时间，默认60s

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
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self clearTextField];
}

#pragma mark - Button action

- (void)registerAction {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


- (void)pwdLoginAction {
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect originFrame = self.slideView.frame;
        originFrame.origin.x = (SCREEN_WIDTH / 2.0 - 110*WIDTH_SCALE) / 2.0;
        self.slideView.frame = originFrame;
        
        self.codeView.hidden = YES;
        self.passwdView.hidden = NO;
        
    } completion:^(BOOL finished) {
        [self clearTextField];
    }];
}

- (void)codeLoginAction {
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect originFrame = self.slideView.frame;
        originFrame.origin.x = SCREEN_WIDTH / 2.0 + (SCREEN_WIDTH / 2.0 - 110*WIDTH_SCALE) / 2.0;
        self.slideView.frame = originFrame;
        self.codeView.hidden = NO;
        self.passwdView.hidden = YES;
        
    } completion:^(BOOL finished) {
        [self clearTextField];
    }];
    
}

- (void)getCode {
    
    if (self.phoneText.text.length < 11) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    self.timeInterval = 61;
    self.getCodeBtn.enabled = NO;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    
    [SVProgressHUD show];
    
    [Request postURL:getCodeURL params:@{@"phoneNo":self.codePhoneText.text} completion:^(BOOL success, id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
        }
    }];
}

- (void)forgetPwd {
    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithViewControllerType:ForgetPwd];

    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginByPwd {
    [SVProgressHUD show];
    
    [Request postURL:loginURL params:@{@"phoneNo":self.phoneText.text,@"password":self.pwdText.text} completion:^(BOOL success, id responseObject, NSError *error) {
        
        if (success) {
            [SVProgressHUD dismiss];
            [[DataCenter sharedInstance] loginSuccessedWithData:responseObject[@"data"]];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            
            [SVProgressHUD showInfoWithStatus:error.domain];
            
        }
    }];
}

- (void)loginByCode {
    [SVProgressHUD show];
    
    [Request postURL:checkCodeURL params:@{@"phoneNo":self.codePhoneText.text,@"verifyCode":self.codeText.text} completion:^(BOOL success, id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        if (success) {
            [[DataCenter sharedInstance] loginSuccessedWithData:responseObject[@"data"]];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }];
}

#pragma mark - UI

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
        make.height.mas_equalTo(@32);
    }];
    
    [self.codeLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@45);
        make.right.mas_equalTo(self.view.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH / 2.0);
        make.height.mas_equalTo(@32);
    }];
  
    self.slideView.frame = CGRectMake((SCREEN_WIDTH / 2.0 - 110*WIDTH_SCALE) / 2.0, 75, 110*WIDTH_SCALE,  2);
    
//    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.pwdLogin.mas_bottom).offset(3);
//        make.width.mas_equalTo(110*WIDTH_SCALE);
//        make.height.mas_equalTo(2);
//        make.centerX.mas_equalTo(self.pwdLogin.mas_centerX);
//    }];
  
    self.passwdView = [[UIView alloc] init];
    [self.view addSubview:self.passwdView];
    
    self.codeView = [[UIView alloc] init];
    [self.view addSubview:self.codeView];
    
    [self.passwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdLogin.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.view.mas_bottom);
//        make.width.mas_equalTo(SCREEN_WIDTH);
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdLogin.mas_bottom).offset(15);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);

    }];
    
    self.codeView.backgroundColor = [UIColor whiteColor];
    self.passwdView.backgroundColor = [UIColor whiteColor];

    
    // left
    
    self.phoneText = [GQUIControl textFieldWithPlaceHolder:@"请输入您的手机号"
                                                  textFont:[UIFont systemFontOfSize:13]
                                                 textColor:grayColor
                                             textAlignment:NSTextAlignmentLeft];
    self.phoneText.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.phoneText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    self.phoneText.layer.borderWidth = 1;
    self.phoneText.layer.cornerRadius = 5;
    [self.passwdView addSubview:self.phoneText];
    
    self.pwdText = [GQUIControl textFieldWithPlaceHolder:@"请输入密码"
                                                textFont:[UIFont systemFontOfSize:13]
                                               textColor:grayColor
                                           textAlignment:NSTextAlignmentLeft];
    self.pwdText.backgroundColor = UIColorFromRGB(0xf3f3f3);
    self.pwdText.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    self.pwdText.layer.cornerRadius = 5;
    self.pwdText.layer.borderWidth = 1;
    [self.passwdView addSubview:self.pwdText];
    
    self.forgetBtn = [GQUIControl buttonWithTitle:@"忘记密码"
                                       titleColor:orangeColor
                                         textFont:[UIFont systemFontOfSize:12]];
    [self.forgetBtn addTarget:self
                       action:@selector(forgetPwd)
             forControlEvents:UIControlEventTouchUpInside];
    [self.passwdView addSubview:self.forgetBtn];
    
    self.loginBtn = [GQUIControl buttonWithTitle:@"登录"
                                      titleColor:[UIColor whiteColor]
                                        textFont:[UIFont systemFontOfSize:16]];
    self.loginBtn.backgroundColor = orangeColor;
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn addTarget:self
                      action:@selector(loginByPwd)
            forControlEvents:UIControlEventTouchUpInside];
    [self.passwdView addSubview:self.loginBtn];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.passwdView.mas_top).offset(10);
        make.right.mas_equalTo(self.passwdView.mas_right).offset(-37*WIDTH_SCALE);
        make.left.mas_equalTo(self.passwdView.mas_left).offset(37*WIDTH_SCALE);
        make.height.mas_equalTo(40);
    }];
    
    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(20);
        make.right.mas_equalTo(self.passwdView.mas_right).offset(-37*WIDTH_SCALE);
        make.left.mas_equalTo(self.passwdView.mas_left).offset(37*WIDTH_SCALE);
        make.height.mas_equalTo(40);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdText.mas_bottom).offset(20);
        make.right.mas_equalTo(self.phoneText.mas_right);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.forgetBtn.mas_bottom).offset(20);
        make.right.left.mas_equalTo(self.phoneText);
        make.height.mas_equalTo(40);
    }];
    
    
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
                      action:@selector(loginByCode)
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
    
    
    self.codeView.hidden = YES;
}

#pragma mark - Function

- (void)countDown:(NSTimer *)timer {
    self.timeInterval -= 1;
    if ( self.timeInterval < 0) {
        [timer invalidate];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getCodeBtn.enabled = YES;
            [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            
        });
    } else {
        NSString *title = [NSString stringWithFormat:@"%lds",(long)self.timeInterval];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.getCodeBtn setTitle:title forState:UIControlStateNormal];
            
        });
        
    }
}

- (void)clearTextField {
    self.pwdText.text = @"";
    self.codePhoneText.text = @"";
    self.phoneText.text = @"";
    self.codeText.text = @"";
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
