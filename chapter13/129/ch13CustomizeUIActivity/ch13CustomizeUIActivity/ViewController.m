//
//  ViewController.m
//  ch13CustomizeUIActivity
//
//  Created by HU QIAO on 2013/12/07.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "LINEActivity.h"
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

// 텍스트를 게시한다
- (IBAction)shareTextToLine:(id)sender {
    
    // 게시 내용
    NSString *plainString = @"LINE으로 보낸다 게시 내용 http://www.shoeisha.co.jp";
    
    // 퍼센트 인코딩（utf-8）한 텍스트 정보의 값을 지정한다
    NSString *postString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                        NULL,
                                                                                        (CFStringRef)plainString,
                                                                                        NULL,
                                                                                        (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                        kCFStringEncodingUTF8 );
    [self shareItem:postString];
    
}

// 이미지를 게시한다
- (IBAction)shareImageToLine:(id)sender {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shoeisha_logo" ofType:@"jpg"];
    [self shareItem:[[UIImage alloc]initWithContentsOfFile:imagePath]];

}

- (void)shareItem:(id)item
{
    
    //activityItems에는 공유할 오브젝트를 배열로 전달한다
    NSArray *activityItems = @[item];
    
    // 커스터마이즈 LINEActivity를 호출한다
    NSArray *applicationActivities = @[[[LINEActivity alloc] init]];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    [self presentViewController:activityViewController animated:YES completion:NULL];
    
}


@end
