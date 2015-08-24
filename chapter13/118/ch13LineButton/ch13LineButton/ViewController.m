//
//  ViewController.m
//  ch13LineButton
//
//  Created by HU QIAO on 2013/12/03.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postImgToLine:(id)sender {

    //반드시 pasteboard를 general로 해주세요.
    //ios7부터 general이 아니면 LINE으로 이미지를 게시할 수 없게 된다.
    UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"jpg"];
  	UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
    [pasteboard setData:UIImageJPEGRepresentation(image, 0.5) forPasteboardType:@"public.jpeg"];
    
    
    //이미지를 보낼 때에 지정
    NSString *contentType = @"image";
    
    NSString *urlString = [NSString stringWithFormat:@"line://msg/%@/%@", contentType, pasteboard.name];
    NSURL *url = [NSURL URLWithString:urlString];

    // LINE으로 직접 전환
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        //LINE이 설치되어 있지 않은 경우
        NSLog(@"the LINE app is not installed.");
    }

}

- (IBAction)postTextToLine:(id)sender {
    
    //게시 내용
    NSString *plainString = @"LINE으로 보낸다　보내는 내용 http://www.shoeisha.co.jp";

    //퍼센트 인코딩（utf-8）한 텍스트 정보 값을 지정
    NSString *contentKey = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)plainString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    //텍스트 정보를 보낼 때에 지정
    NSString *contentType = @"text";
    
    NSString *urlString = [NSString stringWithFormat:@"line://msg/%@/%@", contentType, contentKey];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // LINE으로 직접 전환
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        //LINE이 설치되어 있지 않은 경우
        NSLog(@"the LINE app is not installed.");
    }
    
}

@end
