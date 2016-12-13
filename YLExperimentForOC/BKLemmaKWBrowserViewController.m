//
//  ViewController.m
//  WKWebViewTest
//
//  Created by Sheng,Yilin on 16/11/30.
//  Copyright © 2016年 com.personal. All rights reserved.
//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "BKLemmaKWBrowserViewController.h"
#import "BKLemmaExternalBrowserViewController.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"


@interface BKLemmaKWBrowserViewController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, assign) BOOL onceLoad;

@end

@implementation BKLemmaKWBrowserViewController

- (instancetype)initWithURL:(NSString *)URL {
    if (self = [super init]) {
        self.URLString = URL;
        _onceLoad = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URLString]]];
}

- (void)addSubViews {
    [self.view addSubview:self.wkWebView];
}

#pragma mark - WKWebView WKNavigationDelegate 相关
// 是否允许加载网页在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    if (_onceLoad) {
     decisionHandler(WKNavigationActionPolicyAllow);
    } else {
     decisionHandler(WKNavigationActionPolicyCancel);
  
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:1];
        NSLog(@"protocolHead=%@",protocolHead);
        NSArray *urlCompsTemp = [protocolHead componentsSeparatedByString:@"."];
        if ([urlCompsTemp count] && [[urlCompsTemp objectAtIndex:0] containsString:@"baike"]) {
            BKLemmaKWBrowserViewController *nextWebViewController = [[BKLemmaKWBrowserViewController alloc] initWithURL:urlString];
          //  [MBProgressHUD showHUDAddedTo:nextWebViewController.view animated:YES];
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:nextWebViewController.view];
            [nextWebViewController.view addSubview:hud];
            NSString *info = [NSString stringWithFormat:@"Loading"];
            [hud setLabelText:info];
            [hud setDetailsLabelText:@"Please wait..."];
            [hud setDimBackground:YES];
            [hud setOpacity:0.5f];
            [hud show:YES];
            [hud hide:YES afterDelay:5];
            [self.navigationController pushViewController:nextWebViewController animated:NO];
        } else {
            BKLemmaExternalBrowserViewController *nextWebViewController = [[BKLemmaExternalBrowserViewController alloc] initWithURL:urlString];
          [self presentViewController:nextWebViewController animated:YES completion:nil];
          [self.navigationController popViewControllerAnimated:NO];
        }
    }
 
    }
  
}

// 网页加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _onceLoad = false;
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation something is wrong");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation  something is wrong");
}

#pragma mark - WKUIDelegate Method
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

#pragma mark - searchBar 代理方法
// 点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 创建url
    NSURL *url = nil;
    NSString *urlStr = searchBar.text;
    
    // 如果file://则为打开bundle本地文件，http则为网站，否则只是一般搜索关键字
    if([urlStr hasPrefix:@"file://"]) {
        NSRange range = [urlStr rangeOfString:@"file://"];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    } else if(urlStr.length > 0) {
        if ([urlStr hasPrefix:@"http://"]) {
            url = [NSURL URLWithString:urlStr];
        } else {
            urlStr = [NSString stringWithFormat:@"http://baike.baidu.com/item/%@",urlStr];
        }
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url = [NSURL URLWithString:urlStr];
        
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求页面
    [self.wkWebView loadRequest:request];
}

#pragma mark - 懒加载
- (WKWebView *)wkWebView {
    if (_wkWebView == nil) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        webView.allowsBackForwardNavigationGestures = YES;
        _wkWebView = webView;
    }

    return _wkWebView;
}

@end
