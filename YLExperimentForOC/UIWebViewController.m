//
//  ViewController.m
//  WebViewTest
//
//  Created by mdd on 16/3/9.
//  Copyright © 2016年 com.personal. All rights reserved.
//

/// 控件高度
#define kSearchBarH  44
#define kBottomViewH 44

// 屏幕大小尺寸
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "UIWebViewController.h"
#import <WebKit/WebKit.h>


@interface UIWebViewController () <UISearchBarDelegate, UIWebViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
/// 网页控制导航栏
@property (weak, nonatomic) UIView *bottomView;

@property (nonatomic, strong) UIWebView *webView;

@property (weak, nonatomic) UIButton *backBtn;
@property (weak, nonatomic) UIButton *forwardBtn;
@property (weak, nonatomic) UIButton *reloadBtn;
@property (weak, nonatomic) UIButton *browserBtn;
//
@property (weak, nonatomic) NSString *baseURLString;

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self simpleExampleTest];
    [self addSubViews];
    // 刷新前进后退按钮
    [self refreshBottomButtonState];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/mddblog/"]]];
   // [self deleteNewsSource];

}
- (void)simpleExampleTest {
    // 1.创建webview，并设置大小，"20"为状态栏高度
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    // 2.创建请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/mddblog/"]];
    // 3.加载网页
    [webView loadRequest:request];
    
    // 最后将webView添加到界面
    [self.view addSubview:webView];
}
- (void)addSubViews {
    [self addBottomViewButtons];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.webView];
    
    [self.view bringSubviewToFront:self.bottomView];
    
}

- (void)addBottomViewButtons {
    // 记录按钮个数
    int count = 0;
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"后退" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:249 / 255.0 green:102 / 255.0 blue:129 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    button.tag = ++count;    // 标记按钮
    [button addTarget:self action:@selector(onBottomButtonsClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:button];
    self.backBtn = button;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"前进" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:249 / 255.0 green:102 / 255.0 blue:129 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    button.tag = ++count;
    [button addTarget:self action:@selector(onBottomButtonsClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:button];
    self.forwardBtn = button;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:249 / 255.0 green:102 / 255.0 blue:129 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    button.tag = ++count;
    [button addTarget:self action:@selector(onBottomButtonsClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:button];
    self.reloadBtn = button;
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Safari" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:249 / 255.0 green:102 / 255.0 blue:129 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    button.tag = ++count;
    [button addTarget:self action:@selector(onBottomButtonsClicled:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:button];
    self.browserBtn = button;
    // 统一设置frame
    [self setupBottomViewLayout];
}
- (void)setupBottomViewLayout
{
    int count = 4;
    CGFloat btnW = 80;
    CGFloat btnH = 30;
    
    CGFloat btnY = (self.bottomView.bounds.size.height - btnH) / 2;
    // 按钮间间隙
    CGFloat margin = (self.bottomView.bounds.size.width - btnW * count) / count;
    
    CGFloat btnX = margin * 0.5;
    self.backBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    btnX = self.backBtn.frame.origin.x + btnW + margin;
    self.forwardBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    btnX = self.forwardBtn.frame.origin.x + btnW + margin;
    self.reloadBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    btnX = self.reloadBtn.frame.origin.x + btnW + margin;
    self.browserBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
}
- (void)refreshBottomButtonState {
    if ([self.webView canGoBack]) {
        self.backBtn.enabled = YES;
    } else {
        self.backBtn.enabled = NO;
    }
    
    if ([self.webView canGoForward]) {
        self.forwardBtn.enabled = YES;
    } else {
        self.forwardBtn.enabled = NO;
    }
}
/// 按钮点击事件
- (void)onBottomButtonsClicled:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            [self.webView goBack];
            [self refreshBottomButtonState];
        }
            break;
        case 2:
        {
            [self.webView goForward];
            [self refreshBottomButtonState];
        }
            break;
        case 3:
            [self.webView reload];
            break;
        case 4:
            [[UIApplication sharedApplication] openURL:self.webView.request.URL];
            break;
        default:
            break;
    }
}
#pragma mark - WebView Delegate 相关
/// 是否允许加载网页，也可获取js要打开的url，通过截取此url可与js交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    NSLog(@"urlString=%@---urlComps=%@",urlString,urlComps);
    return YES;
}
/// 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSURLRequest *request = webView.request;
    NSLog(@"webViewDidStartLoad-url=%@--%@",[request URL],[request HTTPBody]);
}
/// 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURLRequest *request = webView.request;
    NSURL *url = [request URL];
    if ([url.path isEqualToString:@"/normal.html"]) {
        NSLog(@"isEqualToString");
    }
    NSLog(@"webViewDidFinishLoad-url=%@--%@",[request URL],[request HTTPBody]);
    // 刷新前进后退按钮
    [self refreshBottomButtonState];
    NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}
/// 网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSURLRequest *request = webView.request;
    NSLog(@"didFailLoadWithError-url=%@--%@",[request URL],[request HTTPBody]);
    
}

#pragma mark - searchBar 代理方法
/// 点击搜索按钮后搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // 创建url
    NSURL *url = nil;
    NSString *urlStr = searchBar.text;
    
    // 如果file://则为打开bundle本地文件，http则为网站，否则只是一般搜索关键字
    if([urlStr hasPrefix:@"file://"]){
        NSRange range = [urlStr rangeOfString:@"file://"];
        NSString *fileName = [urlStr substringFromIndex:range.length];
        // 加载Bundle里面的文件
        url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        // 如果是模拟器加载电脑上的文件，则用下面的代码
//        url = [NSURL fileURLWithPath:fileName];
    }else if(urlStr.length>0){
        if ([urlStr hasPrefix:@"http://"]) {
            url=[NSURL URLWithString:urlStr];
        } else {
            urlStr=[NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@",urlStr];
        }
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        url=[NSURL URLWithString:urlStr];
        
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求页面
    [self.webView loadRequest:request];
}

- (void)deleteNewsSource {
    // 1.去掉页面标题
    NSMutableString *str = [NSMutableString string];
    // 去掉导航页
    // [str appendString:@"document.getElementsByClassName('g-header')[0].style.display = 'none';"];
    // 来源
    [str appendString:@"if(document.getElementsByClassName('g-wrapper-author')[0].innerHTML.indexOf('&nbsp;') == -1){document.getElementsByClassName('g-wrapper-author')[0].innerHTML = document.getElementsByClassName('g-wrapper-author')[0].innerHTML}else{document.getElementsByClassName('g-wrapper-author')[0].innerHTML = document.getElementsByClassName('g-wrapper-author')[0].innerHTML.split('&nbsp;')[1];}"];
    // 执行js代码
    [_webView stringByEvaluatingJavaScriptFromString:str];
}

#pragma mark - 懒加载
- (UIView *)bottomView {
    if (_bottomView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kBottomViewH - 70, kScreenWidth, kBottomViewH)];
        view.backgroundColor = [UIColor whiteColor]; //[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        [self.view addSubview:view];
        _bottomView = view;
    }
    return _bottomView;
}
- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kSearchBarH)];
        searchBar.delegate = self;
        _searchBar = searchBar;
        
    }
    return _searchBar;
}
- (UIWebView *)webView {
    if (_webView == nil) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20 + kSearchBarH, kScreenWidth, kScreenHeight - 20 - kSearchBarH - kBottomViewH)];
        webView.delegate = self;
//        webView.scrollView.scrollEnabled = NO;
        // 屏幕大小自适应
        webView.scalesPageToFit = YES;
        _webView = webView;
    }
    return _webView;
}
@end
