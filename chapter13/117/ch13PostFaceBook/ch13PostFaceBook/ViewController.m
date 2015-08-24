//
//  ViewController.m
//  ch13PostFaceBook
//
//  Created by HU QIAO on 2013/12/03.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <Social/Social.h>
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

// Facebook에 게시
- (IBAction)postToFaceBook:(id)sender {
    
    // Facebook를 이용할 수 있는 단말인지（단말의 Facebook 계정을 설정하여 있는지）를 검증한다
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        // SLComposeViewController를 SLServiceTypeFacebook을 지정하여 작성한다.
        SLComposeViewController *controller = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        // 텍스트
        [controller setInitialText:@"Facebook으로 게시"];
        // 이미지
        [controller addImage:[UIImage imageNamed:@"shoeisha_logo.gif"]];
        // URL
        [controller addURL:[NSURL URLWithString:@"http://www.shoeisha.co.jp"]];

        // 처리 종료 후에 호출되는 콜백을 지정한다
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            
            if (result == SLComposeViewControllerResultCancelled) {
                //Cancel되었습니다.
                NSLog(@"Cancelled");
                
            } else
            {
                //Post되었습니다.
                NSLog(@"Post");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler = myBlock;
        
        
        // 모달에서 표시
        [self presentViewController:controller animated:YES completion:^{
            // SLComposeViewController가 표시된 때에 호출된다
            NSLog(@"presentViewController completion");
        }];
    } else {
        // 단말에 Facebook 계정을 설정하지 않는 경우
         NSLog(@"Facebook is not Available");
    }
    
}

@end
