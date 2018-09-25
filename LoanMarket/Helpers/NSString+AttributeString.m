//
//  NSString+AttributeString.m
//  Meihuishuo
//
//  Created by Mac on 15/11/26.
//  Copyright © 2015年 Gap. All rights reserved.
//

#import "NSString+AttributeString.h"

@implementation NSString (AttributeString)

+ (NSMutableAttributedString *)setTextLineSpace:(CGFloat)lineSpace withString:(NSString *)string {
    if (!string) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    return attributedString;
}

+ (NSMutableAttributedString *)setTextLineSpace:(CGFloat)lineSpace withString:(NSString *)string withFont:(CGFloat)fontSize {
    NSMutableAttributedString *attString = [self setTextLineSpace:lineSpace withString:string];
    [attString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:NSMakeRange(0, attString.length)];
    return attString;
}

@end
