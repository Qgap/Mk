//
//  UIConstants.h
//  LoanMarket
//
//  Created by gap on 2018/9/16.
//  Copyright © 2018年 gq. All rights reserved.
//

#ifndef UIConstants_h
#define UIConstants_h

#define Font11 [UIFont systemFontOfSize:11]
#define Font12 [UIFont systemFontOfSize:12]
#define Font13 [UIFont systemFontOfSize:13]
#define Font14 [UIFont systemFontOfSize:14]
#define Font15 [UIFont systemFontOfSize:15]
#define Font16 [UIFont systemFontOfSize:16]
#define Font17 [UIFont systemFontOfSize:17]
#define Font18 [UIFont systemFontOfSize:18]
#define Font20 [UIFont systemFontOfSize:20]

#define RGB(r, g, b)     [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define black_Color [UIColor colorWithRed:52.0/255.f green:53.0/255.f blue:55.0/255.f alpha:1.f]
#define gray_Color [UIColor colorWithRed:145/255.f green:149/255.f blue:153/255.f alpha:1.f]
#define black_light RGB(65,67,69)

#define grayColor RGB(154,154,154)
#define orangeColor RGB(253,153,50)
#define blackColor RGB(58,58,58)
#define themeColor UIColorFromRGB(0x5bd8ca)

#define SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define HEIGHT_SCALE                        SCREEN_HEIGHT / 667
#define WIDTH_SCALE                         SCREEN_WIDTH / 375

#define IPHONE_4    SCREEN_HEIGHT == 480.0f
#define IPHONE_5    SCREEN_HEIGHT == 568.0f
#define IPHONE_6    SCREEN_HEIGHT == 667.0f
#define IPHONE_6P   SCREEN_HEIGHT == 736.0f



#define null(string) (isEmptyStr(string)?@"":string)
#define nullStr(string,defaultString) (isEmptyStr(string) ? defaultString : string)
#define WS(weakSelf,self)  __weak __typeof(&*self)weakSelf = self;

#endif /* UIConstants_h */
//

