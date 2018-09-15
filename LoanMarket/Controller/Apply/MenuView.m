//
//  MenuView.m
//  LoanMarket
//
//  Created by gap on 2017/12/19.
//  Copyright © 2017年 gq. All rights reserved.
//

#import "MenuView.h"

static CGFloat kTriangleWidth = 15.0;

static CGFloat kItemHeight = 52.0;

@interface MenuView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSArray *dataArray;

@property (nonatomic, assign)CGRect originRect;

@property (nonatomic, assign)CGPoint showPoint;
@property (nonatomic, assign,getter = isUp)BOOL up;

@end

@implementation MenuView

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withArray:(NSArray *)array {
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        self.dataArray = array;
        self.originRect = frame;
        self.up = frame.origin.y > SCREEN_HEIGHT - CGRectGetMaxY(frame);
        self.showPoint = CGPointMake(SCREEN_WIDTH - 50, self.up ? frame.origin.y : CGRectGetMaxY(frame));
        
        [self addSubview:self.tableView];
        [self showTableView];
        [self setNeedsDisplay];
    }
    return self;
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 40;
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        _tableView.layer.cornerRadius = 5.0f;
        _tableView.layer.masksToBounds = YES;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableView;
}

- (void)layoutTableView {
    NSInteger itemCountMax = isIphone4 ? 4: 5;
    
    CGFloat tableViewH = (self.dataArray.count <= itemCountMax ? self.dataArray.count: itemCountMax) * 52.0;
    
    if (self.isUp) {
        self.tableView.frame = CGRectMake(10, self.showPoint.y - (kTriangleWidth - 5) - tableViewH, self.frame.size.width - 20, tableViewH);
    } else {
        self.tableView.frame = CGRectMake(10, self.showPoint.y + kTriangleWidth - 5, self.frame.size.width - 20,tableViewH);
    }
}

- (void)showTableView {
    self.alpha = 0;
    self.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(1,1);
        self.alpha = 1;
        [self layoutTableView];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissTableView {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
    }];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat y = self.up ? self.showPoint.y - (kTriangleWidth - 5): self.showPoint.y + kTriangleWidth -5;
    CGPoint locationPoint = CGPointMake(SCREEN_WIDTH/2.0, self.showPoint.y);
    CGPoint leftPoint = CGPointMake(SCREEN_WIDTH/2.0 - kTriangleWidth/2.0, y);
    CGPoint rightPoint = CGPointMake(SCREEN_WIDTH/2.0 + kTriangleWidth/2.0, y);
    CGContextMoveToPoint(ctx, locationPoint.x, locationPoint.y);
    CGContextAddLineToPoint(ctx, leftPoint.x, leftPoint.y);
    CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
    [[UIColor whiteColor] set];
    CGContextClosePath(ctx);
    
//    CGContextStrokePath(ctx); // 空心
    CGContextFillPath(ctx); // 填充
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.Selector) {
        self.Selector(self.dataArray[indexPath.row]);
    }
    [self dismissTableView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissTableView];
}

@end
