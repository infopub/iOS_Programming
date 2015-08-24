//
//  ViewController.m
//  ch14UserDefaults
//
//  Created by HU QIAO on 2014/01/19.
//  Copyright (c) 2014年 shoeisya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // NSUserDefaults 인스턴스 구하기
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 설정값 구하기
    NSString *frontName = [defaults objectForKey:@"firstname"];
    NSString *lastName = [defaults objectForKey:@"lastname"];
    long age = [defaults integerForKey:@"age"];
    NSString *ageString = [NSString stringWithFormat:@"%li",age];
    
    // UI를 갱신
    _firstNameTextField.text = frontName;
    _lastNameTextField.text = lastName;
    _ageTextField.text = ageString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    // 키보드를 비표시로
    [_firstNameTextField resignFirstResponder];
    [_lastNameTextField resignFirstResponder];
    [_ageTextField resignFirstResponder];
    
    // 입력값을 구하기
    NSString *firstName = [_firstNameTextField text];
    NSString *lastName = [_lastNameTextField text];
    long age = [[_ageTextField text] integerValue];
    
    // NSUserDefaults 인스턴스 구하기
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 입력값을 NSUserDefaults 인스턴스에 설정
    [defaults setObject:firstName forKey:@"firstname"];
    [defaults setObject:lastName forKey:@"lastname"];
    [defaults setInteger:age forKey:@"age"];
    
    // 싱크로나이즈
    BOOL successful = [defaults synchronize];

    if (successful) {
        NSLog(@"%@", @"설정 저장에 성공했습니다.");
    }

}

@end
