//
//  Ch01_UIAlertView_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/12.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIAlertView_02_ViewController.h"

@interface Ch01_UIAlertView_02_ViewController ()

@end

@implementation Ch01_UIAlertView_02_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// UIAlertViewStyleDefault：텍스트 필드가 표시되지 않음
- (IBAction)showAlertViewWithDefault:(id)sender {
    // 알림뷰를 작성
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertView 타이틀"
                          message:@"버튼을 눌러주세요."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleDefault;
    // UIAlertViewDelegate 구현을 지정
    alert.delegate = self;
    alert.tag = 1;
    // 알림뷰를 표시
    [alert show];
}

// UIAlertViewStyleSecureTextInput：비밀 번호 입력용 텍스트 필드가 표시된다
- (IBAction)showAlertViewWithUIAlertViewStylePlainTextInput:(id)sender {
    // 알림뷰를 작성
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertView 타이틀"
                          message:@"버튼을 눌러주세요."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    // UIAlertViewDelegate 구현을 지정
    alert.delegate = self;
    alert.tag = 2;
    // 알림뷰를 표시
    [alert show];
}

// UIAlertViewStylePlainTextInput：보통 텍스트 입력용 필드가 표시
- (IBAction)showAlertViewWithPlainTextInput:(id)sender {
    // 알림뷰를 작성
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertView 타이틀"
                          message:@"버튼을 눌러주세요."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    // UIAlertViewDelegate 구현을 지정
    alert.delegate = self;
    alert.tag = 3;
    // 알림뷰를 표시
    [alert show];
}

// UIAlertViewStyleLoginAndPasswordInput： 사용자 ID 입력용 필드와 비밀번호 입력 텍스트 필드가 표시
- (IBAction)showAlertWithLoginAndPasswordInput:(id)sender {
    // 알림뷰를 작성
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertView 타이틀"
                          message:@"버튼을 눌러주세요."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    // UIAlertViewDelegate 구현을 지정
    alert.delegate = self;
    alert.tag = 4;
    // 알림뷰를 표시
    [alert show];
}


-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // １번째 버튼 「Cancel」이 눌렸을 때 처리를 기술
            self.uiLabel.text = @"Cancel 버튼을 선택했다.";
            break;
        case 1:
            if(1 == alertView.tag) {
                break;
            }
            if(4 == alertView.tag){
                // 로그인 필드
                self.uiLabel.text = [[alertView textFieldAtIndex:0] text];
                // 비밀번호 필드
                self.uiLabel2.text = [[alertView textFieldAtIndex:1] text];
            } else {
                self.uiLabel.text = [[alertView textFieldAtIndex:0] text];
            }

            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
