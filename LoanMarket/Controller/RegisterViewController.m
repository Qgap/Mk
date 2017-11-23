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

static CGFloat padding_Hor = 37;

static CGFloat padding_Ver = 20;

static CGFloat lineHeight = 40;

@interface RegisterViewController ()

@property (nonatomic, strong)UIScrollView *mainScroll;
@property (nonatomic, strong)UITextField *phoneText;
@property (nonatomic, strong)UITextField *codeText;
@property (nonatomic, strong)UIButton *getCodeButton;
@property (nonatomic, strong)UITextField *pwdText;
@property (nonatomic, strong)UITextField *secondPwdText;
@property (nonatomic, strong)UIButton *selectBtn;
@property (nonatomic, strong)UILabel *licenseLabel;
@property (nonatomic, strong)UIButton *registerBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
}


- (void)setupUI {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.mainScroll = [GQUIControl scrollViewWithFrame:self.view.frame
                                           contentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)
                                               showVer:NO
                                               showHor:NO
                                              delegate:nil
                          IStranslatesAutoresizingMask:YES];
    [self.view addSubview:self.mainScroll];
    
    
    self.phoneText = [self unitTextFieldPlaceHolder:@"请输入手机号"];
    
    self.codeText = [self unitTextFieldPlaceHolder:@"请输入验证码"];
    
    self.pwdText = [self unitTextFieldPlaceHolder:@"请输入密码"];
    
    self.secondPwdText = [self unitTextFieldPlaceHolder:@"请再次输入密码"];
    
    self.getCodeButton = [GQUIControl buttonWithTitle:@"获取验证码" titleColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:13]];
    [self.mainScroll addSubview:self.getCodeButton];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mainScroll addSubview:self.selectBtn];
    
    self.licenseLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:12] textColor:grayColor textAlignment:NSTextAlignmentLeft];
    [self.mainScroll addSubview:self.licenseLabel];
    
    self.registerBtn = [GQUIControl buttonWithTitle:@"快速注册"
                                         titleColor:grayColor
                                           textFont:[UIFont systemFontOfSize:16]];
    [self.mainScroll addSubview:self.registerBtn];
    
    
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
        make.top.mas_equalTo(self.secondPwdText.mas_bottom).offset(padding_Ver);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    [self.licenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectBtn.mas_right).offset(10*WIDTH_SCALE);
        make.top.mas_equalTo(self.secondPwdText.mas_bottom).offset(padding_Ver);
        
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-padding_Hor*WIDTH_SCALE);
        make.left.mas_equalTo(self.view.mas_left).offset(padding_Hor*WIDTH_SCALE);
        make.top.mas_equalTo(self.licenseLabel.mas_bottom).offset(30 * WIDTH_SCALE);
    }];
}

- (UITextField *)unitTextFieldPlaceHolder:(NSString *)placeHolder {
    UITextField *textField = [GQUIControl textFieldWithPlaceHolder:placeHolder
                                                  textFont:[UIFont systemFontOfSize:13]
                                                 textColor:grayColor
                                             textAlignment:NSTextAlignmentLeft];
    textField.backgroundColor = UIColorFromRGB(0xf3f3f3);
    textField.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 5;
    [self.mainScroll addSubview:textField];
    return textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
