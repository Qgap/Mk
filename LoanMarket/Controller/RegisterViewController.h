//
//  ViewController.h
//  LoanMarket
//
//  Created by gap on 2017/11/20.
//  Copyright © 2017年 gq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ViewControllerType) {
    RegisterAcount,
    ForgetPwd
};

@interface RegisterViewController : UIViewController

- (id)initWithViewControllerType: (ViewControllerType)vcType;

@end

