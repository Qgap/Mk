//
//  AdvertisingColumn.m
//  LoanMarket
//
//  Created by gap on 2017/11/21.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "AdvertisingColumn.h"
#import "GQUIControl.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AdvertisingColumn () <UIScrollViewDelegate>

@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)UIScrollView *adScroll;

@property (nonatomic, strong)NSMutableArray *imageArr;

@property (nonatomic, assign)float scrollerHeight;

@end

@implementation AdvertisingColumn

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.adScroll = [GQUIControl scrollViewWithFrame:frame
                                               contentSize:CGSizeZero
                                                   showVer:NO
                                                   showHor:NO
                                                  delegate:self
                              IStranslatesAutoresizingMask:NO];
        
        self.scrollerHeight = frame.size.height;
        self.imageArr = [NSMutableArray array];
        [self addSubview:self.adScroll];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    self.adScroll.frame = frame;
    self.scrollerHeight = frame.size.height;
    [super setFrame:frame];
}

- (void)setScrollerHeight:(float)scrollerHeight {
    if (scrollerHeight) {
        _scrollerHeight = scrollerHeight;
        CGRect rect = self.adScroll.frame;
        rect.size.height = scrollerHeight;
        self.adScroll.frame = rect;
    }
}

- (void)setArray:(NSArray *)imgArray {
    
    NSInteger count = imgArray.count;
    [self.imageArr removeAllObjects];
    [self.imageArr addObjectsFromArray:imgArray];
    
    self.adScroll.delegate = self;
    if (count >1) {
        self.adScroll.contentSize = CGSizeMake(SCREEN_WIDTH * (count+2) , self.scrollerHeight);
    } else {
        self.adScroll.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollerHeight);
    }
    if (count == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollerHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.adScroll addSubview:imageView];
    } else {
        // 用于图片更新，先清空所有创建的控件，防止不断重复叠加。
        for (UIImageView *subImageView in self.adScroll.subviews) {
            [subImageView removeFromSuperview];
        }
        
        
        for (int i = 0; i < count; i ++) {
            UIImageView *image = [[UIImageView alloc] init];
            
            if (count >1) {
                image.frame = CGRectMake(SCREEN_WIDTH *(i+1), 0, SCREEN_WIDTH, self.scrollerHeight);
            } else{
                image.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, self.scrollerHeight);
            }
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            [tap setNumberOfTapsRequired:1];
            [image addGestureRecognizer:tap];
            tap.view.tag = 120 +i;
            image.contentMode = UIViewContentModeScaleAspectFit;
            [image sd_setImageWithURL:[NSURL URLWithString:imgArray[i]] placeholderImage:[UIImage imageNamed:@"gary_head"]];
            [self.adScroll addSubview:image];
        }
        
        if (count >1) {

            UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*(imgArray.count+1), 0, SCREEN_WIDTH, self.scrollerHeight)];
            [lastImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[0]]];
            [self.adScroll addSubview:lastImageView];
            
            UIImageView *fristImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollerHeight)];
            [fristImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr.lastObject]];
            [self.adScroll addSubview:fristImageView];
            
            [self.adScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
            
            [self.timer invalidate];
            self.timer = nil;
            
            [self timerInit];
        }
    }
    self.adScroll.scrollsToTop = NO;
}

#pragma mark---- UIScrollView delegate methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始拖动scrollview的时候 停止计时器控制的跳转
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self setupContentOffset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self setupContentOffset];
    
    [self timerInit];
}

#pragma mark - Private Method

- (void)nextPage {
    CGPoint contentOffset = self.adScroll.contentOffset;
    contentOffset.x = contentOffset.x + SCREEN_WIDTH;
    [self.adScroll setContentOffset:contentOffset animated:YES];
}

- (void)imageClick:(UITapGestureRecognizer *)sender {
    if (self.adImageClick) {
        self.adImageClick(sender);
    }
}

- (void)setupContentOffset {
    if (self.adScroll.contentOffset.x == 0) {
        self.adScroll.contentOffset = CGPointMake(self.imageArr.count *SCREEN_WIDTH, 0);
    } else if(self.adScroll.contentOffset.x >= (self.imageArr.count+1) * SCREEN_WIDTH){
        self.adScroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }
}

- (void)timerInit {
    self.timer = [NSTimer timerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(nextPage)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end
