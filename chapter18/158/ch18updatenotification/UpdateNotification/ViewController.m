//
//  ViewController.m
//  UpdateNotification
//
//  Created by katsuya on 2014/01/21.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // id를 임의의 앱 ID로 변경한다
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=443904275"]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30.0];
    NSURLResponse *response;
    NSError *error;
    
    // 동기로 SearchAPI를 호출한다
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];
    
    // API의 레스폰스(JSON)을 파서한다
    NSDictionary *dictionary  = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&error];
    NSDictionary *results = [[dictionary objectForKey:@"results"] objectAtIndex:0];
    
    // 키 「version」이 앱의 버전에 해당한다
    NSString *latestVersion = [results objectForKey:@"version"];
    
    // 현재 버전
    NSString *currentVersion = [[NSBundle mainBundle]
                                objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    // 버전이 같지 않음 = AppStore에 새로운 버전의 앱이 있다고 한다
    if (![currentVersion isEqualToString:latestVersion]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"업데이트가 있습니다"
                                                       delegate:self
                                              cancelButtonTitle:@"취소"
                                              otherButtonTitles:@"AppStore로 이동", nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        NSURL* url= [NSURL URLWithString:@"https://itunes.apple.com/kr/app/lain-line/id443904275?mt=8"];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
