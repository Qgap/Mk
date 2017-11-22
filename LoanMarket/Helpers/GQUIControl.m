//
//  GQ_UIControl.m
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "GQUIControl.h"


@implementation GQUIControl

+ (UIImageView *)imageViewContentModel:(UIViewContentMode)contentmode {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = contentmode;
    return imageView;
}


+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame
                         contentSize:(CGSize)contentSize
                             showVer:(BOOL)showVer
                             showHor:(BOOL)showHor
                            delegate:(id)Target
        IStranslatesAutoresizingMask:(BOOL)ISmask {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:frame];
    scroll.contentSize = contentSize;
    scroll.showsHorizontalScrollIndicator = showHor;
    scroll.showsVerticalScrollIndicator = showVer;
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.translatesAutoresizingMaskIntoConstraints = ISmask;
    scroll.delegate = Target;
    return scroll;
}

+ (CALayer *)layerWithFrame:(CGRect)frame borderColor:(UIColor *)color {
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    layer.borderColor = color.CGColor;
    return layer;

}

+ (UIButton *)buttonWithTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                    textFont:(UIFont *)font {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

+ (UILabel *)labelWithTextFont:(UIFont *)font
                        textColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)textAlignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;

    return label;
}

#pragma mark - UITextField

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder
                                 textFont:(UIFont *)font
                                textColor:(UIColor *)textColor
                            textAlignment:(NSTextAlignment)textAlignment {
    
   return [self textFieldWithPlaceHolder:placeholder
                          textFont:font
                         textColor:textColor
                     textAlignment:textAlignment
                   placeHolderFont:nil
                  placeHolderColor:nil];
    
}

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder
                                  textFont:(UIFont *)font
                                 textColor:(UIColor *)textColor
                             textAlignment:(NSTextAlignment)textAlignment
                           placeHolderFont:(UIFont *)placeholderFont
                          placeHolderColor:(UIColor *)placeholderColor {
    
    UITextField *textField = [[UITextField alloc] init];
    textField.font = font;
    textField.textColor = textColor;
    textField.textAlignment = textAlignment;
    
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    if (placeholderFont) {
        [textField setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
    if (placeholderColor) {
        [textField setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return textField;
}

@end
