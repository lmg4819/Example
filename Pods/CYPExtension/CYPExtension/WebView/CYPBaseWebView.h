//
//  CYPBaseWebView.h
//  CarEasyBuy
//
//  Created by 吴林杰 on 2017/4/17.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"

@class CYPBaseWebView;
@protocol CYPBaseWebViewDelegate <NSObject>
@optional

/*
 webview加载代理
 */
- (void)CYPWebView:(CYPBaseWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request;
- (void)CYPWebViewDidStartLoad:(CYPBaseWebView *)webView;
- (void)CYPWebViewDidFinishLoad:(CYPBaseWebView *)webView;
- (void)CYPWebView:(CYPBaseWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@interface CYPBaseWebView : UIView<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong)WebViewJavascriptBridge *bridge;
@property (nonatomic, strong)WKWebViewJavascriptBridge *WKbridge;
@property (nonatomic, copy) void (^WKTitleblock)(NSString *title);
@property (nonatomic, weak) id <CYPBaseWebViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame requestWithWebUrl:(NSString *)url;

- (void)requestWithWebUrl:(NSString *)url;
/*
 js返回数据回调
 */
- (void)registerCYPWebViewHandler:(NSString*)handlerName dataBlock:(void (^)(NSDictionary *dataDic))success;
- (void)registerCYPWebViewHandler:(NSString *)handlerName handleBlock:(void(^)(NSDictionary *dataDic,WVJBResponseCallback responseCallback))handleBlock;
- (void)callCYPWebViewHandler:(NSString*)handlerName data:(id)data responseCallback:(void (^)(NSDictionary *dataDic))success;
- (NSString*)stringByEvaluatingJavaScriptFromString:(NSString*)javaScriptString __deprecated_msg("Method deprecated. Use [evaluateJavaScript:completionHandler:]");
- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler;

@property (nonatomic, strong) id BaseWebView;
///是否正在使用 UIWebView
@property (nonatomic, readonly) BOOL usingUIWebView;
@property (nonatomic, readonly, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;

@property (nonatomic, readonly) NSURLRequest* currentRequest;
@property (nonatomic, readonly) NSURL* URL;

#pragma mark - NSURLDelegate
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadURL:(NSURL *)URL;
- (void)loadURLString:(NSString *)URLString;
- (void)loadHTMLString:(NSString *)HTMLString;

#pragma mark - JavascriptDelegate
@property (nonatomic) BOOL scalesPageToFit;
@property (nonatomic, readonly) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;
- (void)goBack;
- (void)goForward;
- (void)reload;
- (void)stopLoading;
#pragma mark - 截图
- (void)CYP_ContentCaptureCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler;
@end
