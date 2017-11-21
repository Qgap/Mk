//
//  Header.h
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */

#define SCREEN_WIDTH                        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                       ([UIScreen mainScreen].bounds.size.height)
#define HEIGHT_SCALE                        SCREEN_HEIGHT / 667
#define WIDTH_SCALE                         SCREEN_WIDTH / 375

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
