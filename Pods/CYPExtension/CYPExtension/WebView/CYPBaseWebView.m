//
//  CYPBaseWebView.m
//  CarEasyBuy
//
//  Created by 吴林杰 on 2017/4/17.
//  Copyright © 2017年 北京巅峰科技有限公司. All rights reserved.
//

#import "CYPBaseWebView.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"

@implementation CYPBaseWebView{
    UIProgressView *progressView;
}

@synthesize usingUIWebView = _usingUIWebView;
@synthesize scalesPageToFit = _scalesPageToFit;
@synthesize currentRequest = _currentRequest;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createWebView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame requestWithWebUrl:(NSString *)url{
    self = [super initWithFrame:frame];
    if (self) {
        [self createWebView];
        [self requestWithWebUrl:url];
    }
    return self;
}

- (void)createWebView{
    
    self.backgroundColor = [UIColor whiteColor];
    if([[[UIDevice currentDevice]systemVersion] floatValue] < 9.0) {
        self.uiWebView = [[UIWebView alloc] init];
        [self.uiWebView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.uiWebView setDelegate:self];
        [self.uiWebView setMultipleTouchEnabled:YES];
        [self.uiWebView setAutoresizesSubviews:YES];
        [self.uiWebView setScalesPageToFit:YES];
        [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
        self.uiWebView.scrollView.bounces = NO;
        self.uiWebView.scrollView.delegate = self;
        [self addSubview:self.uiWebView];
        
        self.BaseWebView = self.uiWebView;
        _usingUIWebView = YES;
        
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.uiWebView];
    }else {
        self.wkWebView = [[WKWebView alloc] init];
        [self.wkWebView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.wkWebView setNavigationDelegate:self];
        [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.wkWebView setUIDelegate:self];
        [self.wkWebView setMultipleTouchEnabled:YES];
        [self.wkWebView setAutoresizesSubviews:YES];
        [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
        self.wkWebView.scrollView.bounces = NO;
        self.wkWebView.scrollView.delegate = self;
        [self addSubview:self.wkWebView];
        
        self.BaseWebView = self.wkWebView;
        _usingUIWebView = NO;
        
        //WK添加进度条
        progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame),2)];
        progressView.trackTintColor = [UIColor clearColor];//ff7145
        progressView.progressTintColor = [UIColor colorWithRed:1. green:113/255. blue:69/255. alpha:1.];
        [self addSubview:progressView];
        
        [self.BaseWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
        
        self.WKbridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    }
    
//    if(_usingUIWebView) {
//        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.uiWebView];
////        [self.bridge setWebViewDelegate:self];
//    }
//    else{
//        self.WKbridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
////        [self.WKbridge setWebViewDelegate:self];
//    }
    
}

- (void)requestWithWebUrl:(NSString *)url {
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self loadRequest:request];
}

- (void)registerCYPWebViewHandler:(NSString *)handlerName dataBlock:(void (^)(NSDictionary *))success{
    if (_usingUIWebView) {
        [self.bridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(data);
                }
            }
        }];
    }else{
        [self.WKbridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(data);
                }
            }
        }];
    }
}

- (void)registerCYPWebViewHandler:(NSString *)handlerName handleBlock:(void(^)(NSDictionary *dataDic,WVJBResponseCallback responseCallback))handleBlock
{
    if (_usingUIWebView) {
        [self.bridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if (handleBlock) {
                    handleBlock(data,responseCallback);
                }
            }
        }];
    }else{
        [self.WKbridge registerHandler:handlerName handler:^(id data, WVJBResponseCallback responseCallback) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if (handleBlock) {
                    handleBlock(data,responseCallback);
                }
            }
        }];
    }
}

- (void)callCYPWebViewHandler:(NSString*)handlerName data:(id)data responseCallback:(void (^)(NSDictionary *dataDic))success
{
    if (_usingUIWebView) {
        [self.bridge callHandler:handlerName data:data responseCallback:^(id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(data);
                }
            }
        }];
    }else{
        [self.WKbridge callHandler:handlerName data:data responseCallback:^(id responseData) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(data);
                }
            }
        }];
    }
}

#pragma mark - NSURLDelegate
- (void)loadRequest:(NSURLRequest *)request {
    if(self.wkWebView) {
        [self.wkWebView loadRequest:request];
    }
    else  {
        [self.uiWebView loadRequest:request];
    }
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    if(self.wkWebView) {
        [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
    }
    else if(self.uiWebView) {
        [self.uiWebView loadHTMLString:HTMLString baseURL:nil];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if(_usingUIWebView) {
        if ([self.delegate respondsToSelector:@selector(CYPWebViewDidStartLoad:)]){
            [self.delegate CYPWebViewDidStartLoad:self];
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([self.delegate respondsToSelector:@selector(CYPWebView:shouldStartLoadWithRequest:)]){
        [self.delegate CYPWebView:self shouldStartLoadWithRequest:request];
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.delegate respondsToSelector:@selector(CYPWebViewDidFinishLoad:)]){
        [self.delegate CYPWebViewDidFinishLoad:self];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(CYPWebView:didFailLoadWithError:)]){
        [self.delegate CYPWebView:self didFailLoadWithError:error];
    }
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    _currentRequest = navigationAction.request;
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if(!_usingUIWebView) {
        if ([self.delegate respondsToSelector:@selector(CYPWebViewDidStartLoad:)]){
            [self.delegate CYPWebViewDidStartLoad:self];
        }
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if(!_usingUIWebView) {
        if ([self.delegate respondsToSelector:@selector(CYPWebViewDidFinishLoad:)]){
            [self.delegate CYPWebViewDidFinishLoad:self];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(!_usingUIWebView) {
        if ([self.delegate respondsToSelector:@selector(CYPWebView:didFailLoadWithError:)]){
            [self.delegate CYPWebView:self didFailLoadWithError:error];
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if(!_usingUIWebView) {
        if ([self.delegate respondsToSelector:@selector(CYPWebView:didFailLoadWithError:)]){
            [self.delegate CYPWebView:self didFailLoadWithError:error];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual: @"estimatedProgress"] && object == _wkWebView) {
        [progressView setAlpha:1.0f];
        [progressView setProgress:_wkWebView.estimatedProgress animated:YES];
        if(_wkWebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [progressView setProgress:0.0f animated:NO];
            }];
        }
    }else {
        if ([keyPath isEqualToString:@"title"]) {
            if (object == self.wkWebView) {
                __weak __typeof(self)weakSelf = self;
                if (self.WKTitleblock) {
                    self.WKTitleblock(weakSelf.wkWebView.title);
                }
            }
        }else {
             [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
       
    }
}

-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType{
    if ([self.delegate respondsToSelector:@selector(CYPWebView:shouldStartLoadWithRequest:)]){
        [self.delegate CYPWebView:self shouldStartLoadWithRequest:request];
    }
    return YES;
}

#pragma mark - JavascriptDelegate1

- (void)evaluateJavaScript:(NSString*)javaScriptString completionHandler:(void (^)(id, NSError*))completionHandler{
    if (_usingUIWebView) {
        NSString* result = [self.uiWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        if (completionHandler) {
            completionHandler(result, nil);
        }
    }
    else {
        return [self.wkWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    }
}

- (NSString*)stringByEvaluatingJavaScriptFromString:(NSString*)javaScriptString{
    if (_usingUIWebView) {
        NSString* result = [self.uiWebView stringByEvaluatingJavaScriptFromString:javaScriptString];
        return result;
    }
    else {
        __block NSString* result = nil;
        __block BOOL isExecuted = NO;
        [self.wkWebView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError* error) {
            result = obj;
            isExecuted = YES;
        }];
        
        while (isExecuted == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        return result;
    }
}

- (UIScrollView *)scrollView{
    if(!_usingUIWebView) {
        return self.wkWebView.scrollView;
    }else{
        return self.uiWebView.scrollView;
    }
}

#pragma mark - Set-Get-Delegate
- (NSURLRequest*)currentRequest{
    if (_usingUIWebView) {
        return [self.uiWebView request];
        ;
    }
    else {
        return _currentRequest;
    }
}
- (NSURL*)URL{
    if (_usingUIWebView) {
        return [self.uiWebView request].URL;
        ;
    }
    else {
        return [self.wkWebView URL];
    }
}
- (void)setScalesPageToFit:(BOOL)scalesPageToFit{
    if (_usingUIWebView) {
        UIWebView* webView = self.uiWebView;
        webView.scalesPageToFit = scalesPageToFit;
    }
    else {
        if (_scalesPageToFit == scalesPageToFit) {
            return;
        }
        
        WKWebView* webView = self.wkWebView;
        
        NSString* jScript =
        @"var head = document.getElementsByTagName('head')[0];\
        var hasViewPort = 0;\
        var metas = head.getElementsByTagName('meta');\
        for (var i = metas.length; i>=0 ; i--) {\
        var m = metas[i];\
        if (m.name == 'viewport') {\
        hasViewPort = 1;\
        break;\
        }\
        }; \
        if(hasViewPort == 0) { \
        var meta = document.createElement('meta'); \
        meta.name = 'viewport'; \
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
        head.appendChild(meta);\
        }";
        
        WKUserContentController *userContentController = webView.configuration.userContentController;
        NSMutableArray<WKUserScript *> *array = [userContentController.userScripts mutableCopy];
        WKUserScript* fitWKUScript = nil;
        for (WKUserScript* wkUScript in array) {
            if ([wkUScript.source isEqual:jScript]) {
                fitWKUScript = wkUScript;
                break;
            }
        }
        if (scalesPageToFit) {
            if (!fitWKUScript) {
                fitWKUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
                [userContentController addUserScript:fitWKUScript];
            }
        }
        else {
            if (fitWKUScript) {
                [array removeObject:fitWKUScript];
            }
            ///没法修改数组 只能移除全部 再重新添加
            [userContentController removeAllUserScripts];
            for (WKUserScript* wkUScript in array) {
                [userContentController addUserScript:wkUScript];
            }
        }
    }
    _scalesPageToFit = scalesPageToFit;
}
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
////    [LIUseFunc alertWithMessage:message];
//    completionHandler();
//}
//
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
//    completionHandler(YES);
//}
//wk禁止缩放
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//    return nil;
//}

- (BOOL)scalesPageToFit{
    if (_usingUIWebView) {
        return [self.uiWebView scalesPageToFit];
    }
    else {
        return _scalesPageToFit;
    }
}

- (BOOL)loading{
    if(!_usingUIWebView) {
        return self.wkWebView.loading;
    }else{
        return self.uiWebView.loading;
    }
}
- (BOOL)canGoBack{
    if(!_usingUIWebView) {
        return self.wkWebView.canGoBack;
    }else{
        return self.uiWebView.canGoBack;
    }
}
- (BOOL)canGoForward{
    if(!_usingUIWebView) {
        return self.wkWebView.canGoForward;
    }else{
        return self.uiWebView.canGoForward;
    }
}

#pragma mark - JavascriptDelegate2
- (void)goBack{
    if(!_usingUIWebView) {
        [self.wkWebView goBack];
    }else{
        [self.uiWebView goBack];
    }
}
- (void)goForward{
    if(!_usingUIWebView) {
        [self.wkWebView goForward];
    }else{
        [self.uiWebView goForward];
    }
}
- (void)reload{
    if(!_usingUIWebView) {
        [self.wkWebView reload];
    }else{
        [self.uiWebView reload];
    }
}
- (void)stopLoading{
    if(!_usingUIWebView) {
        [self.wkWebView stopLoading];
    }else{
        [self.uiWebView stopLoading];
    }
}

#pragma mark - Dealloc
- (void)dealloc {
    [_wkWebView removeObserver:self forKeyPath:@"title"];
    if (_usingUIWebView) {
        _uiWebView.delegate = nil;
    }
    else {
        _wkWebView.UIDelegate = nil;
        _wkWebView.navigationDelegate = nil;
        
        [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    }
    [_BaseWebView scrollView].delegate = nil;
    [_BaseWebView stopLoading];
    [(UIWebView*)_BaseWebView loadHTMLString:@"" baseURL:nil];
    [_BaseWebView stopLoading];
    [_BaseWebView removeFromSuperview];
    _BaseWebView = nil;
}

#pragma mark - 截图
- (void)CYP_ContentCaptureCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler{
    CGPoint offset = self.scrollView.contentOffset;
    
    UIView *snapShotView = [self snapshotViewAfterScreenUpdates:YES];
    snapShotView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, snapShotView.frame.size.width, snapShotView.frame.size.height);
    [self.superview addSubview:snapShotView];
    
    if(self.frame.size.height < self.scrollView.contentSize.height){
        self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentSize.height - self.frame.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentOffset = CGPointZero;
        
        [self CYP_ContentCaptureWithoutOffsetCompletionHandler:^(UIImage *capturedImage) {
            self.scrollView.contentOffset = offset;
            
            [snapShotView removeFromSuperview];
            
            completionHandler(capturedImage);
        }];
    });
    
}

- (void)CYP_ContentCaptureWithoutOffsetCompletionHandler:(void(^)(UIImage *capturedImage))completionHandler{
    UIView *containerView = [[UIView alloc]initWithFrame:self.bounds];
    
    CGRect bakFrame = self.frame;
    UIView *bakSuperView = self.superview;
    NSInteger bakIndex = [self.superview.subviews indexOfObject:self];
    
    [self removeFromSuperview];
    [containerView addSubview:self];
    
    CGSize totalSize = self.scrollView.contentSize;
    
    float page = floorf(totalSize.height/containerView.bounds.size.height);
    
    self.frame = CGRectMake(0, 0, containerView.bounds.size.width, self.scrollView.contentSize.height);
    UIGraphicsBeginImageContextWithOptions(totalSize, false, [UIScreen mainScreen].scale);
    [self CYP_ContentPageDrawTargetView:containerView index:0 maxIndex:(int)page drawCallback:^{
        UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self removeFromSuperview];
        [bakSuperView insertSubview:self atIndex:bakIndex];
        
        self.frame = bakFrame;
        
        [containerView removeFromSuperview];
        
        completionHandler(capturedImage);
    }];
    
}

- (void)CYP_ContentPageDrawTargetView:(UIView *)targetView index:(int)index maxIndex:(int)maxIndex drawCallback:(void(^)())drawCallback{
    CGRect splitFrame = CGRectMake(0, (float)index * targetView.frame.size.height, targetView.bounds.size.width, targetView.frame.size.height);
    
    CGRect myFrame = self.frame;
    myFrame.origin.y = - ((float)index * targetView.frame.size.height);
    self.frame = myFrame;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [targetView drawViewHierarchyInRect:splitFrame afterScreenUpdates:YES];
        
        if(index<maxIndex){
            [self CYP_ContentPageDrawTargetView:targetView index:index + 1 maxIndex:maxIndex drawCallback:drawCallback];
        }else{
            drawCallback();
        }
    });
}

@end
