//
//  ViewController.m
//  WKWebViewTest
//
//  Created by Sheng,Yilin on 16/11/30.
//  Copyright © 2016年 com.personal. All rights reserved.
//

/// 控件高度
#define kSearchBarH  44
#define kBottomViewH 44

// 屏幕大小尺寸
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "BKLemmaKWBrowserViewController.h"
#import <WebKit/WebKit.h>


@interface BKLemmaKWBrowserViewController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, copy) NSString *URLString;
@property (nonatomic, assign) BOOL onceLoad; // 页面只能加载一次

@end

@implementation BKLemmaKWBrowserViewController

- (instancetype)initWithURL:(NSString *)URL {
    if (self = [super init]) {
        self.URLString = URL;
        _onceLoad = true;
    }
    return self;
}

/*
 
 - (instancetype)initWithFrame:(CGRect)frame {
 if (self = [super initWithFrame:frame]) {
 [self setHeaderImage];
 [self setContentLabel];
 }
 return self;
 }
 

 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URLString]]];
}

- (void)simpleExampleTest {
    // 1.创建webview，并设置大小，"20"为状态栏高度
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://baike.baidu.com/item/baike"]];
    // 3.加载网页
    [webView loadRequest:request];
    
    // 最后将webView添加到界面
    [self.view addSubview:webView];
}

- (void)addSubViews {
    [self.view addSubview:self.wkWebView];
}

#pragma mark - WKWebView WKNavigationDelegate 相关
/// 是否允许加载网页在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    if (_onceLoad) {
     decisionHandler(WKNavigationActionPolicyAllow);
    } else {
     decisionHandler(WKNavigationActionPolicyCancel);
     BKLemmaKWBrowserViewController *nextWebViewController = [[BKLemmaKWBrowserViewController alloc] initWithURL:urlString];
     [self.navigationController pushViewController:nextWebViewController animated:NO];
        
    }
  
    // 解码
    urlString = [urlString stringByRemovingPercentEncoding];
    // NSLog(@"urlString=%@",urlString);
    // 用:// 截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        NSLog(@"protocolHead=%@",protocolHead);
    }

}

/// 网页加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _onceLoad = false;
   // [self getImageUrlByJS:self.wkWebView];
   // [self refreshBottomButtonState];
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
/// 点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 创建url
    NSURL *url = nil;
    NSString *urlStr = searchBar.text;
    
    // 如果file://则为打开bundle本地文件，http则为网站，否则只是一般搜索关键字
    if([urlStr hasPrefix:@"file://"]) {
        NSRange range = [urlStr rangeOfString:@"file://"];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        // 如果是模拟器加载电脑上的文件，则用下面的代码
//        url = [NSURL fileURLWithPath:fileName];
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
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 20 )];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        // webView.scrollView.scrollEnabled = NO;
        
        // webView.backgroundColor = [UIColor colorWithPatternImage:self.image];
        // 允许左右划手势导航，默认允许
        webView.allowsBackForwardNavigationGestures = YES;
        _wkWebView = webView;
    }

    return _wkWebView;
}


@end
