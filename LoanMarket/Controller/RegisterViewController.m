//
//  ViewController.m
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "RegisterViewController.h"
#import "GQUIControl.h"
#import <Masonry.h>
#import "UIImage+Category.h"
#import <TTTAttributedLabel.h>
#import "LoginViewController.h"
#import "Validator.h"
#import <SVProgressHUD.h>
#import "Request.h"
#import "DataCenter.h"
#import "WKWebViewController.h"

static CGFloat padding_Hor = 37;

static CGFloat padding_Ver = 20;

static CGFloat lineHeight = 40;

@interface RegisterViewController () <TTTAttributedLabelDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong)UIScrollView *mainScroll;
@property (nonatomic, strong)UITextField *phoneText;
@property (nonatomic, strong)UITextField *codeText;
@property (nonatomic, strong)UIButton *getCodeButton;
@property (nonatomic, strong)UITextField *pwdText;
@property (nonatomic, strong)UITextField *secondPwdText;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)TTTAttributedLabel *licenseLabel;
@property (nonatomic, strong)UIButton *registerBtn;
@property (nonatomic, strong)UIButton *togoLoginBtn;

@property (nonatomic, assign)NSInteger timeInterval;// 倒计时时间，默认60s
@property (nonatomic, assign)NSInteger vcType;
@end

@implementation RegisterViewController

- (id)initWithViewControllerType: (ViewControllerType)vcType {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.vcType = vcType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     self.title = @"注册";
    
    if (!self.vcType) {
        self.vcType = RegisterAcount;
    }
    
    if (self.vcType == ForgetPwd) {
        self.title = @"忘记密码";
    }
    
    [self setupUI];
    
}


- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    
    WKWebViewController *vc = [[WKWebViewController alloc] initWithUrl:url.absoluteString];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"TTTAttributedLabel"]) {
        
        [self.view endEditing:YES];
        return NO;
    }
    
    return YES;
}

#pragma mark - Button Action

- (void)getCode {
    
    if (self.phoneText.text.length < 11) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    self.timeInterval = 61;
    self.getCodeButton.enabled = NO;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    
    [SVProgressHUD show];
    [Request postURL:getCodeURL params:@{@"phoneNo":self.phoneText.text} completion:^(BOOL success, id responseObject, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"已发送验证码"];
        } else {
            [SVProgressHUD showInfoWithStatus:error.domain];
        }
    }];
    
}

- (void)countDown:(NSTimer *)timer {
    self.timeInterval -= 1;
    if ( self.timeInterval < 0) {
        [timer invalidate];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.getCodeButton.enabled = YES;
            [self.getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            
        });
    } else {
        NSString *title = [NSString stringWithFormat:@"%lds",(long)self.timeInterval];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.getCodeButton setTitle:title forState:UIControlStateNormal];

        });
        
    }
}

- (void)togoLogin {
   __block BOOL hasContainLogin = NO;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LoginViewController class]]) {
            hasContainLogin = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
        *stop = YES;
    }];
    
    if (!hasContainLogin) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

- (void)registerAccount {
    
    if (![Validator isValidateMobile:self.phoneText.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
    } else if (self.codeText.text.length <3) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
    } else if (self.pwdText.text.length < 6) {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
    } else if (![self.pwdText.text isEqualToString:self.secondPwdText.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致"];
    } else if (!self.selectBtn.isSelected && self.vcType == RegisterAcount){
        [SVProgressHUD showInfoWithStatus:@"请先阅读并同意用户注册协议"];
    } else {
    
        NSDictionary *params = @{@"phoneNo":self.phoneText.text,
                                 @"verifyCode":self.codeText.text,
                                 @"password":self.pwdText.text
                                 };
        
        [SVProgressHUD show];
        [Request postURL:registerURL params:params completion:^(BOOL success, id responseObject, NSError *error) {
            [SVProgressHUD dismiss];
            if (success) {
                [[DataCenter sharedInstance] loginSuccessedWithData:responseObject[@"data"]];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            } else {
                [SVProgressHUD showInfoWithStatus:error.domain];
            }
        }];
    }
    
}

- (void)agreeProtocol {
    self.selectBtn.selected = !self.selectBtn.selected;
}

- (void)textFieldsChange:(UITextField *)sender {
//    if (self.phoneText.text.length == 11) {
//        self.getCodeButton.enabled = YES;
//    } else {
//        self.getCodeButton.enabled = NO;
//    }
    
    if (self.phoneText.text.length > 0 &&self.codeText.text.length > 0 && self.pwdText.text.length > 0 && self.secondPwdText.text.length > 0) {
        self.registerBtn.enabled = YES;
    } else {
        self.registerBtn.enabled = NO;
    }

}

#pragma mark - UI init

- (void)setupUI {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.mainScroll = [GQUIControl scrollViewWithFrame:self.view.frame
                                           contentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)
                                               showVer:NO
                                               showHor:NO
                                              delegate:nil
                          IStranslatesAutoresizingMask:YES];
    [self.view addSubview:self.mainScroll];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyborad)];
    tapGesture.delegate = self;
    [self.mainScroll addGestureRecognizer:tapGesture];
    
    self.phoneText = [self unitTextFieldPlaceHolder:@"请输入手机号"];
    self.phoneText.keyboardType = UIKeyboardTypePhonePad;
    
    self.codeText = [self unitTextFieldPlaceHolder:@"请输入验证码"];
    self.codeText.keyboardType = UIKeyboardTypePhonePad;
    
    self.pwdText = [self unitTextFieldPlaceHolder:@"请输入密码"];
    
    self.secondPwdText = [self unitTextFieldPlaceHolder:@"请再次输入密码"];
    
    self.getCodeButton = [GQUIControl buttonWithTitle:@"获取验证码"
                                           titleColor:[UIColor whiteColor]
                                             textFont:[UIFont systemFontOfSize:13]];
//    self.getCodeButton.enabled = NO;
    [self.getCodeButton setBackgroundImage:[UIImage createImageWithColor:grayColor] forState:UIControlStateDisabled];
    [self.getCodeButton setBackgroundImage:[UIImage createImageWithColor:orangeColor] forState:UIControlStateNormal];
    [self.getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScroll addSubview:self.getCodeButton];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"agree_normal"] forState:UIControlStateNormal];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"agree_select"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(agreeProtocol) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScroll addSubview:self.selectBtn];
    

    self.licenseLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    
    self.licenseLabel.tintColor = grayColor;
    self.licenseLabel.font = [UIFont systemFontOfSize:12];
    self.licenseLabel.textColor = grayColor;
    self.licenseLabel.textAlignment = NSTextAlignmentLeft;
    
    NSString *protocolName = @"《用户注册服务协议》";
    NSString *string = @"我已同意并阅读 ";
    NSMutableAttributedString *tipString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",string,protocolName]];
    
    NSRange stringRange = NSMakeRange(string.length,protocolName.length);
    NSURL *url = [NSURL URLWithString:registerHTML];
    [self.licenseLabel addLinkToURL:url withRange:stringRange];
    
    self.licenseLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    self.licenseLabel.delegate = self;
    
    
    [tipString addAttribute:NSForegroundColorAttributeName
                      value:grayColor
                      range:NSMakeRange(0, string.length)];
    [tipString addAttribute:NSForegroundColorAttributeName
                      value:orangeColor
                      range:NSMakeRange(string.length, protocolName.length)];
    self.licenseLabel.attributedText = tipString;
    [self.mainScroll addSubview:self.licenseLabel];
    
    self.registerBtn = [GQUIControl buttonWithTitle:@"快速注册"
                                         titleColor:[UIColor whiteColor]
                                           textFont:[UIFont systemFontOfSize:16]];
    
    [self.registerBtn setBackgroundImage:[UIImage createImageWithColor:grayColor] forState:UIControlStateDisabled];
    [self.registerBtn setBackgroundImage:[UIImage createImageWithColor:orangeColor] forState:UIControlStateNormal];
    self.registerBtn.enabled = NO;
    [self.registerBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScroll addSubview:self.registerBtn];
    
    self.togoLoginBtn = [GQUIControl buttonWithTitle:@"已有账号，速去登录>>" titleColor:orangeColor textFont:[UIFont systemFontOfSize:12]];
    [self.togoLoginBtn addTarget:self action:@selector(togoLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScroll addSubview:self.togoLoginBtn];
    
    [self.phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(50);
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.height.mas_equalTo(lineHeight);
    }];
    
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(padding_Ver*WIDTH_SCALE);
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.height.mas_equalTo(lineHeight);
        make.width.mas_equalTo(98*WIDTH_SCALE);
    }];
    
    [self.codeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneText.mas_bottom).offset(padding_Ver*WIDTH_SCALE);
        make.height.mas_equalTo(lineHeight);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.right.mas_equalTo(self.getCodeButton.mas_left).offset(-padding_Ver*WIDTH_SCALE);
    }];
    
    [self.pwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeText.mas_bottom).offset(padding_Ver);
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.height.mas_equalTo(lineHeight);
    }];
    
    [self.secondPwdText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pwdText.mas_bottom).offset(padding_Ver);
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.height.mas_equalTo(lineHeight);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.centerY.mas_equalTo(self.licenseLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(10*WIDTH_SCALE);
        make.top.mas_equalTo(self.secondPwdText.mas_bottom).offset(padding_Ver);
        
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.top.mas_equalTo(self.licenseLabel.mas_bottom).offset(30 * WIDTH_SCALE);
        make.height.mas_equalTo(lineHeight);
    }];
    
    [self.togoLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.top.mas_equalTo(self.registerBtn.mas_bottom).offset(padding_Ver * WIDTH_SCALE);
    }];
    
    if (self.vcType == ForgetPwd) {
        self.selectBtn.hidden = YES;
        self.licenseLabel.hidden = YES;
    }
}

- (UITextField *)unitTextFieldPlaceHolder:(NSString *)placeHolder {
    UITextField *textField = [GQUIControl textFieldWithPlaceHolder:placeHolder
                                                  textFont:[UIFont systemFontOfSize:13]
                                                 textColor:blackColor
                                             textAlignment:NSTextAlignmentLeft];
    textField.backgroundColor = UIColorFromRGB(0xf3f3f3);
    textField.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 5;
    [textField addTarget:self action:@selector(textFieldsChange:) forControlEvents:UIControlEventEditingChanged];
    [self.mainScroll addSubview:textField];
    return textField;
}


- (void)hiddenKeyborad {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
