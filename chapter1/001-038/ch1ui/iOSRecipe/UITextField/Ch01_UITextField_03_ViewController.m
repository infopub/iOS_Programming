//
//  Ch01_UITextField_03_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/05.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UITextField_03_ViewController.h"

@interface Ch01_UITextField_03_ViewController ()

@end

@implementation Ch01_UITextField_03_ViewController

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
    
    self.textfield1.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 입력 완료 텍스트 구하기
    NSMutableString *str = [textField.text mutableCopy];
    // 입력 완료 텍스트와 입력되고 있는 텍스트를 결합
    [str replaceCharactersInRange:range withString:string];

    BOOL ret = YES;
    ret =[self isNumber:str];

    return ret;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",@"test");
}

// 숫자 입력 체크
- (BOOL)isNumber:(NSString *)value {
    
    // 빈 문자의 경우는 NO
    if ( (value == nil) || ([@"" isEqualToString:value]) ) {
        return NO;
    }
    
    int l = [value length];
    
    BOOL b = NO;
    for (int i = 0; i < l; i++) {
        NSString *str = [[value substringFromIndex:i] substringToIndex:1];
        const char *c = [str cStringUsingEncoding:NSASCIIStringEncoding];
        if ( c == NULL ) {
            b = NO;
            break;
        }
        if ((c[0] >= 0x30) && (c[0] <= 0x39)) {
            b = YES;
        } else {
            b = NO;
            break;
        }
    }
    
    if (b) {
        return YES;  // 수치 문자열
    } else {
        return NO;
    }
}

@end
