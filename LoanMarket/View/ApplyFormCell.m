//
//  ApplyFormCell.m
//  LoanMarket
//
//  Created by gap on 2017/11/27.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "ApplyFormCell.h"
#import "GQUIControl.h"
#import <Masonry.h>
#import "ApplyViewController.h"
#import "MenuView.h"

typedef NS_ENUM(NSInteger,Selector) {
    Period = 103,
    Identity = 104,
    City = 105,
    CardNum = 107,
    PhoneTime = 108
};

static NSInteger baseTag = 100;

@interface ApplyFormCell () <UITextFieldDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UIView *superView;
@end

@implementation ApplyFormCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [GQUIControl labelWithTextFont:[UIFont systemFontOfSize:15] textColor:blackColor textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:self.titleLabel];
        
        self.titleLabel.frame = CGRectMake(0, 5, 105, 40);
        
        self.inputText = [self unitTextFieldPlaceHolder:@""];
        self.inputText.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, 5, 200 , 40);
        
        self.selectionText = [self unitTextFieldPlaceHolder:@""];
        self.selectionText.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, 5, 165 , 40);
        
        self.arrowImage = [[UIImageView alloc] init];
        self.arrowImage.image = [UIImage imageNamed:@"arrow_down"];
        self.arrowImage.frame = CGRectMake(165 - 40, 0, 40, 40);
        self.arrowImage.contentMode = UIViewContentModeCenter;
        [self.selectionText addSubview:self.arrowImage];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSelector:)];
        [self.selectionText addGestureRecognizer:tap];
        
        CALayer *lineLayer = [GQUIControl layerWithFrame:CGRectMake(0, 0, 1, 40) borderColor:UIColorFromRGB(0xbdbdbd)];
        lineLayer.borderWidth = 1;
        [self.arrowImage.layer addSublayer:lineLayer];
        
        self.genderView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, 5, SCREEN_WIDTH - CGRectGetMaxX(self.titleLabel.frame) - 10, 40)];
        [self.contentView addSubview:self.genderView];
        
        self.manBtn = [self buttonWithTitle:@"男" selected:YES];
        self.manBtn.frame = CGRectMake(0, 0, 40, 40);
        
        self.womanBtn = [self buttonWithTitle:@"女" selected:NO];
        self.womanBtn.frame = CGRectMake(CGRectGetMaxX(self.manBtn.frame) + 10, 0, 40, 40);
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

#pragma mark - Button Action

- (void)boolCheck:(UIButton *)sender {
    sender.selected = YES;
    if (sender == self.manBtn) {
        self.womanBtn.selected = NO;
    } else {
        self.manBtn.selected = NO;
    }
}

- (void)showSelector:(UITapGestureRecognizer *)sender {
    
    [self.applyViewController.view endEditing:YES];
    
    NSLog(@"sender :%ld",sender.view.tag);
    
    CGPoint touchPoint = [sender locationInView:self.superView];
    NSLog(@"touch point :%@",NSStringFromCGPoint(touchPoint));

    NSIndexPath *indexPath = [self.applyViewController.tableView indexPathForCell:self];
    CGRect rectIndexPath = [self.applyViewController.tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [self.applyViewController.tableView convertRect:rectIndexPath toView:self.applyViewController.view];
//    rect.origin.y += 64;
    
    NSLog(@"rect :%@",NSStringFromCGRect(rect));
    
    NSArray *array = @[@"小学",@"初中",@"高中",@"大专",@"本科",@"研究生",@"留学生",@"文盲"];
    MenuView *menuView = [[MenuView alloc] initWithFrame:rect withArray: array];
    menuView.Selector = ^(NSString *text) {
        self.selectionText.text = text;
    };
    
    [self.applyViewController.view addSubview:menuView];
    
    switch (sender.view.tag) {
        case Period:
            
            break;
        case Identity:
            break;
            
        case CardNum:
            break;
        case City:
            break;
        case PhoneTime:
            
            break;
            
        default:
            break;
    }
}

- (ApplyViewController *)applyViewController {
    id responder = self;
    while (responder){
        if ([responder isKindOfClass:[ApplyViewController class]]){
            return responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.applyViewController.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag > baseTag) {
        return NO;
    }
    return YES;
}


#pragma mark - Configure Cell

- (void)setupCell:(NSArray *)dataArray indexPath:(NSIndexPath *)indexPath view:(UIView *)superView {
    
    NSString *title = dataArray[indexPath.row][@"title"];
    self.titleLabel.text = title;
    self.inputText.placeholder = dataArray[indexPath.row][@"placeHolder"];
    
    NSString *type = dataArray[indexPath.row][@"type"];

    if ([type isEqualToString:@"TextField"]) {
        self.inputText.hidden = NO;
        self.selectionText.hidden = YES;
        self.genderView.hidden = YES;
        self.inputText.placeholder = dataArray[indexPath.row][@"placeHolder"];
        
        if ([title isEqualToString:@"姓名"]) {
            self.inputText.keyboardType = UIKeyboardTypeDefault;
        } else {
            self.inputText.keyboardType = UIKeyboardTypePhonePad;
        }
        
    } else if ([type isEqualToString:@"Selector"]) {
        self.inputText.hidden = YES;
        self.selectionText.hidden = NO;
        self.selectionText.placeholder = dataArray[indexPath.row][@"placeHolder"];
        self.genderView.hidden = YES;
        self.selectionText.tag = baseTag + indexPath.row;
    } else {
        self.genderView.hidden = NO;
        self.inputText.hidden = YES;
        self.selectionText.hidden = YES;
    }
}

#pragma mark - UI

- (UITextField *)unitTextFieldPlaceHolder:(NSString *)placeHolder {
    UITextField *textField = [GQUIControl textFieldWithPlaceHolder:placeHolder
                                                          textFont:[UIFont systemFontOfSize:13]
                                                         textColor:blackColor
                                                     textAlignment:NSTextAlignmentLeft];
    textField.backgroundColor = UIColorFromRGB(0xf3f3f3);
    textField.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 5;
    textField.delegate = self;
    [self.contentView addSubview:textField];
    return textField;
}

- (UIButton *)buttonWithTitle:(NSString *)title selected:(BOOL)selected {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.selected = selected;
    [button setImage:[UIImage imageNamed: @"box_selected"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed: @"box_normal"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:blackColor forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(boolCheck:) forControlEvents:UIControlEventTouchUpInside];
    [self.genderView addSubview:button];
    return button;
}

@end
