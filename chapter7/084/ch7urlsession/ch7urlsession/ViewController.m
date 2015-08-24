//
//  ViewController.m
//  ch12notification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableData *receivedData;
    NSURLSessionTask *currentTask;
    NSUInteger dataLength;
}

// 로그에 문자열을 출력한다
- (void)appendLogString:(NSString *)string
{
    _textView.text = [_textView.text stringByAppendingString:string];
    [_textView.layoutManager ensureLayoutForTextContainer:_textView.textContainer];
    [_textView layoutIfNeeded];
    CGFloat y = _textView.contentSize.height - _textView.frame.size.height;
    if (y < 0) {
        y = 0;
    }
    [_textView setContentOffset:CGPointMake(0, y) animated:YES];
}

// 인증이 필요
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    if (currentTask == task) {
        if (![challenge proposedCredential]) {
            // 인증을 아직 한 번도 하지 않은 경우
            NSString *user = @"demouser";
            NSString *password = @"password";
            [self appendLogString:[NSString stringWithFormat:@"인증이 필요합니다. 사용자：%@ 비밀번호：%@로 시도합니다.\n", user, password]];
            
            // 인증에 사용할 자격정보를 작성
            NSURLCredential *credential = [NSURLCredential credentialWithUser:user password:password persistence:NSURLCredentialPersistenceForSession];
            
            // 자격정보를 사용해 인증을 시도한다
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            // 인증 실패
            [self appendLogString:@"인증에 실패했습니다. 취득 처리를 취소합니다.\n"];
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, NULL);
        }
    }
}

// 리스폰스를 수신한다
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    if (currentTask == dataTask) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        // 상태 코드를 구한다
        int status = [httpResponse statusCode];
        [self appendLogString:[NSString stringWithFormat:@"HTTP 상태 코드:%d\n", status]];

        // 헤더를 구한다
        NSDictionary *headers = [httpResponse allHeaderFields];
        for(id key in [headers keyEnumerator]) {
            [self appendLogString:[NSString stringWithFormat:@"[Header] %@: %@\n", key, [headers valueForKey:key]]];
        }
        
        // 데이터 수신용 인스턴스를 초기화한다
        receivedData = [NSMutableData dataWithCapacity:512];
        dataLength = 0;
        
        // 작업을 계속한다
        completionHandler(NSURLSessionResponseAllow);
    }
}

// 데이터를 수신
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (currentTask == dataTask) {
        // 데이터를 수신했을 때의 처리
        // 완료할 때까지 여러 차례 호출되므로 그때마다 스트림에 쓰기 등의 처리를 한다
        [self appendLogString:[NSString stringWithFormat:@"%u바이트의 데이터를 수신했습니다.\n", data.length]];

        // 데이터를 수신용 인스턴스에 추가한다. 또한, 샘플에서는 수신 후 데이터가 512바이트를 초과한 부분을 무시한다.
        if (dataLength < 512) {
            int needLength = 512 - dataLength;
            [receivedData appendData:[data subdataWithRange:NSMakeRange(0, needLength)]];
        }
        dataLength += data.length;
    }
}

// 읽기가 종료되었다
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (currentTask == task) {
        if (!error) {
            // 데이터의 수신이 완료된 경우의 처리
            [self appendLogString:[NSString stringWithFormat:@"수신한 총 데이터 양：%u바이트\n", dataLength]];
            NSString *string = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
            [self appendLogString:[NSString stringWithFormat:@"수신한 데이터의 내용（512바이트까지）：\n%@\n", string]];
        } else {
            // 에러가 발생한 경우의 처리
            [self appendLogString:[NSString stringWithFormat:@"수신에러ー: %@ %d:%@\n", [error domain], [error code], [error localizedDescription]]];
        }
        [self appendLogString:@"읽기가 종료되었습니다！\n\n"];
        // 여기까지 취득한 결과를 삭제
        receivedData = nil;
        
        // NSURLSessionTask 정리하고 삭제
        [currentTask cancel];
        currentTask = nil;
    }
}

// 버튼이 눌렸다
- (IBAction)createLocalNotificationButtonDidPush:(id)sender
{
    if (!currentTask) {
        // 현재 읽기 중이 아니면 읽기를 시작

        // 읽을 URL을 지정한다
        NSURL *url = [NSURL URLWithString:@"http://www.infopub.co.kr/"];    // BASIC 인증모드
        
        [self appendLogString:[[url absoluteString] stringByAppendingString:@"로부터 데이터를 읽기 시작했습니다.\n"]];
        
        // 접속 설정
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 3G/LTE를 이용한 접속을 함
        sessionConfig.allowsCellularAccess = YES;

        // 세션 작성
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        // 태스크를 작성
        currentTask = [session dataTaskWithURL:url];
        // 태스크를 시작
        [currentTask resume];
        
    } else {
        // 현재 읽는 중인 경우 취소한다
        [currentTask cancel];
        currentTask = nil;
        [self appendLogString:@"취소했습니다.\n\n"];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
