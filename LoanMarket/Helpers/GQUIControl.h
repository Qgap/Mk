//
//  GQ_UIControl.h
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GQUIControl : NSObject

+ (UIImageView *)imageViewContentModel:(UIViewContentMode)contentmode;

+ (UIScrollView *)scrollViewWithFrame:(CGRect)frame
                         contentSize:(CGSize)contentSize
                             showVer:(BOOL)showVer
                             showHor:(BOOL)showHor
                            delegate:(id)Target
        IStranslatesAutoresizingMask:(BOOL)ISmask;

+ (CALayer *)layerWithFrame:(CGRect)frame
               borderColor:(UIColor *)color;

+ (UIButton *)buttonWithTitle:(NSString *)title
                  titleColor:(UIColor *)titleColor
                    textFont:(UIFont *)font;

+ (UILabel *)labelWithTextFont:(UIFont *)font
                     textColor:(UIColor *)textColor
                 textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder
                                 textFont:(UIFont *)font
                                textColor:(UIColor *)textColor
                            textAlignment:(NSTextAlignment)textAlignment;

+ (UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder
                                 textFont:(UIFont *)font
                                textColor:(UIColor *)textColor
                            textAlignment:(NSTextAlignment)textAlignment
                          placeHolderFont:(UIFont *)placeholderFont
                         placeHolderColor:(UIColor *)placeholderColor;


@end
