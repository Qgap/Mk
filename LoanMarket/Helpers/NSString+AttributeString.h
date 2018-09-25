//
//  NSString+AttributeString.h
//  Meihuishuo
//
//  Created by Mac on 15/11/26.
//  Copyright © 2015年 Gap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributeString)

+ (NSMutableAttributedString *)setTextLineSpace:(CGFloat)lineSpace withString:(NSString *)string;

+ (NSMutableAttributedString *)setTextLineSpace:(CGFloat)lineSpace withString:(NSString *)string withFont:(CGFloat)fontSize;

@end
