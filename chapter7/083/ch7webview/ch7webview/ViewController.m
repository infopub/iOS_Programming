//
//  ViewController.m
//  ch7webview
//
//  Created by SHOEISHA on 2013/11/17.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSURLAuthenticationChallenge *authChallenge;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 미리 인증에 사용할 자격 정보를 작성
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"demouser" password:@"password" persistence:NSURLCredentialPersistenceForSession];
    // 인증에 필요한 경우의 정보를 작성
    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:@"www.kackun.com" port:80 protocol:NSURLProtectionSpaceHTTP realm:@"Basic Authentication Demo" authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
    // 공유 자격 정보 스토리지에 자격 정보와 위치(장소) 정보를 저장
    [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:protectionSpace];
    
    // URL 문자열로부터 URL 객체를 작성
    NSURL *targetURL = [NSURL URLWithString:@"http://www.infopub.co.kr"];
    // URL로부터 URL 리퀘스트를 작성
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:targetURL];
    // WebView에 열고 싶은 URL을 설정
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 액션 메뉴 열기
- (IBAction)actionButtonDidPush:(id)sender
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Actions" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"Safari에서 열기", @"100 픽셀 아래로 스크롤", nil];
    [as showFromToolbar:self.toolBar];
}

// UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            // JavaScript에서 document.URL을 구해 Safari에서 실행
            NSString *urlString = [self.webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
            NSURL *url = [[NSURL alloc] initWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        }
        case 1:
            // JavaScript을 이용해 100 픽셀 아래로 스크롤
            [self.webView stringByEvaluatingJavaScriptFromString:@"window.scrollTo(0, window.scrollY + 100);"];
            break;
    }
}

// UIWebViewDelegate

// UIWebView가 읽기를 시작함
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressView.progress = 0.1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// UIWebView가 읽기를 종료함
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.progressView.progress = 1.0;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // JavaScript를 이용해 타이틀을 구함
    self.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

// UIWebView에서 읽기를 실패
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.progressView.progress = 0.0;
    if (error.code != NSURLErrorCancelled) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"읽기에 실패 했습니다." message:error.localizedDescription  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
