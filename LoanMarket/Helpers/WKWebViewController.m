//
//  WKWebViewController.m
//  Finance
//
//  Created by gap on 2018/6/13.
//  Copyright © 2018年 cyfuer. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewProgressView.h"

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong)WKWebView *wkWebView;
@property(nonatomic,strong)NSString *urlStr;
@property(nonatomic,strong)WebViewProgressView *progressView;
@end

@implementation WKWebViewController

- (id)initWithUrl:(NSString *)url {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.urlStr = url;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.progressView = [[WebViewProgressView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 2)];
    
    [self.view addSubview:self.progressView];

    [self cleanCacheAndCookie];
    


    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.wkWebView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:YES];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

- (void)cleanCacheAndCookie{
    
    NSArray *typesArray =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
    
    NSSet *types = [NSSet setWithArray:typesArray];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:types modifiedSince:dateFrom completionHandler:^{
        
    }];
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
