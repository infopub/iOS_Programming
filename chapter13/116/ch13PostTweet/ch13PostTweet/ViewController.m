//
//  ViewController.m
//  ch13PostTweet
//
//  Created by HU QIAO on 2013/12/02.
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

- (IBAction)postTweet:(id)sender {
    
    // POST 대상의 item을 Array에 넣는다
    NSArray *activityItems;
    // 텍스트
    NSString* postText = @"test string";
    // 이미지
    UIImage* postImage = [UIImage imageNamed:@"shoeisha_logo.gif"];
    //URL
    NSURL* postUrl = [NSURL URLWithString:@"http://www.shoeisha.co.jp"];
    activityItems = @[postText, postImage, postUrl];
    
    // UIActivityViewController을 작성
    UIActivityViewController *activityController =
    [[UIActivityViewController alloc]
     initWithActivityItems:activityItems
     applicationActivities:nil];
    
    
    // 제외하고 싶은 Share처를 해당하는 상수를 배열에, excludedActivityTypes에 대입
    activityController.excludedActivityTypes =
    @[UIActivityTypePrint,
      UIActivityTypePostToFacebook,
      UIActivityTypeSaveToCameraRoll,
      UIActivityTypeMail
      ];
    
    
    // completionHandler 종료 시의 동작
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed) {
        //동작이 종료한 때에 호출된다
        //activityType:Twitter의 경우는 com.apple.UIKit.activity.PostToTwitter
        //completed: Post된 경우는 1,Cancle된 경우는０
        NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
    }];
    
    // 모달에서 표시
    [self presentViewController:activityController animated:YES completion:^{
        // UIActivityViewController가 표시된 때에 호출된다
        NSLog(@"presentViewController completion");
    }];
}



@end
