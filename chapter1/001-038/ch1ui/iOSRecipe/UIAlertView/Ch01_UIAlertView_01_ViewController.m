//
//  Ch01_UIAlertView_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/08.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIAlertView_01_ViewController.h"

@interface Ch01_UIAlertView_01_ViewController ()

@end

@implementation Ch01_UIAlertView_01_ViewController

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
    
    // 알림뷰를 작성
    // 취소버튼을 표시하지 않는 경우 cancelButtonTitle에 nil을 지정
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"UIAlertView 타이틀"
                          message:@"버튼을 눌러주세요."
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Button1", nil];
    
    // 초기화 후 버튼을 추가
    [alert addButtonWithTitle:@"Button2"];
    // UIAlertViewDelegate 구현을 지정
    alert.delegate = self;
    
    // 알림뷰를 표시
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // １번째 버튼 「Cancel」이 눌렸을 때 처리를 기술
            self.uiLabel.text = @"Cancel 버튼을 선택했다";
            break;
        case 1:
            // ２번째 버튼 「Button1」이 눌렸을 때 처리를 기술
            self.uiLabel.text = @"Button1을 선택했다";
            break;
        case 2:
            // ３번째 버튼 「Button2」가 눌렸을 때 처리를 기술
            self.uiLabel.text = @"Button2를 선택했다";
            break;
        case 3:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
