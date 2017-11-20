//
//  GQ_UIControl.m
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "GQUIControl.h"


@implementation GQUIControl

//+ (UIImageView *)imageView {
//    UIImageView *imageView = [[UIImageView alloc] init];
////    imageView.contentMode =
//
//    return imageView;
//}


+(CALayer *)layerWithFrame:(CGRect)frame borderColor:(UIColor *)color {
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    layer.borderColor = color.CGColor;
    return layer;

}

+(UIButton *)buttonWithTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                    textFont:(UIFont *)font {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

#pragma mark -Label

+ (UILabel *)labelWithPlaceHolder:(NSString *)placeholder
                         textFont:(UIFont *)font
                        textColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)textAlignment {
    
    return [self labelWithPlaceHolder:placeholder
                             textFont:font
                            textColor:textColor
                        textAlignment:textAlignment
                      placeHolderFont:nil
                     placeHolderColor:nil];
    
}

+ (UILabel *)labelWithPlaceHolder:(NSString *)placeholder
                         textFont:(UIFont *)font
                        textColor:(UIColor *)textColor
                    textAlignment:(NSTextAlignment)textAlignment
                  placeHolderFont:(UIFont *)placeholderFont
                 placeHolderColor:(UIColor *)placeholderColor {
    
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    if (placeholderFont) {
        [label setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
    if (placeholderColor) {
        [label setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    
    return label;
}

@end
