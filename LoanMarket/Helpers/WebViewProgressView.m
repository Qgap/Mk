//
//  WebViewProgressView.m
//  Finance
//
//  Created by gap on 2018/6/13.
//  Copyright © 2018年 cyfuer. All rights reserved.
//

#import "WebViewProgressView.h"

static NSTimeInterval barAnimationDuration = 0.27;
static NSTimeInterval fadeAnimationDuration = 0.27;
static NSTimeInterval fadeOutDelay = 0.1;



@interface WebViewProgressView()

@property(nonatomic,strong)UIView *progressBarView;

@end
@implementation WebViewProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.progressBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        self.progressBarView.backgroundColor = UIColorFromRGB(0x6BA6FF);
        [self addSubview:self.progressBarView];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    BOOL isGrowing = progress > 0;
    
    [UIView animateWithDuration:(isGrowing && animated) ? barAnimationDuration: 0 animations:^{
        
        CGRect origin = self.progressBarView.frame;
        origin.size.width = progress * SCREEN_WIDTH;
        self.progressBarView.frame = origin;
        
    } completion:^(BOOL finished) {
        
    }];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated? fadeAnimationDuration:0 delay:fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.progressBarView.alpha = 0;
            
        } completion:^(BOOL finished) {
            CGRect rect = self.progressBarView.frame;
            rect.size.width = 0;
            self.progressBarView.frame = rect;
        }];
    } else {
        [UIView animateWithDuration:animated? fadeAnimationDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.progressBarView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
   
}

@end
