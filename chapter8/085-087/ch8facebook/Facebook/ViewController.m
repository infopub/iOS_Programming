//
//  ViewController.m
//  Facebook
//
//  Created by katsuya on 2014/01/30.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import<FacebookSDK/FacebookSDK.h>

@interface ViewController () <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 로그인 버튼을 생성한다
    FBLoginView *loginview = [[FBLoginView alloc] init];
    loginview.frame = CGRectOffset(loginview.frame, 5, 30);
    loginview.delegate = self;
    [self.view addSubview:loginview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button
- (IBAction)handlePostButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.sdccom.net"];
    
    // Facebook 앱을 실행한다
    FBAppCall *appCall = [FBDialogs presentShareDialogWithLink:url
                                                          name:@"담벼락 테스트"
                                                       caption:@"caption"
                                                   description:@"description"
                                                       picture:nil
                                                   clientState:nil
                                                       handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                           if (error) {
                                                               NSLog(@"에러 %@", error.description);
                                                           } else {
                                                               NSLog(@"성공");
                                                           }
                                                       }];
    
    // Facebook 앱이 설치되어 있지 않다면 iOS의 Facebook으로 담벼락 다이얼로그를 표시한다 
    if (!appCall) {
        [FBDialogs presentOSIntegratedShareDialogModallyFrom:self
                                                 initialText:@"담벼락 테스트"
                                                       image:nil
                                                         url:url
                                                     handler:nil];
    }
}

#pragma mark - FBLoginViewDelegate
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.postButton.enabled = YES;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.postButton.enabled = NO;
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSLog(@"에러%@", error.description);
}

@end
