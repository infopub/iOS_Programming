//
//  ViewController.m
//  ch14iCloudKeyValue
//
//  Created by HU QIAO on 2013/12/17.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *valueField;

@end

@implementation ViewController


static NSString *kStringKey = @"MyString";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // defaultStore 메소드를 사용하여 NSUbiquitousKeyValueStore 오브젝트를 구하기
    NSUbiquitousKeyValueStore* cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    // iCloud와 싱크 시킨다
    [cloudStore synchronize];
    
    // 데이터를 구하기
    NSString *storedString = [cloudStore stringForKey:kStringKey];
    
    if (storedString != nil){
        _valueField.text = storedString;
    }
    
    // iCloud에서 데이터의 변경 통지를 받는 설정
    // 다른 단말에서 iCloud의 데이터가 변경되면
    // NSUbiquitousKeyValueStoreDidChangeExternallyNotification라고 하는 통지가 송신된다.
    // 또한, 앱을 삭제하여 재설치 시에도 통지가 발행되어 iCloud에서의 자동 동기가 실행된다.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(ubiquitousKeyValueStoreDidChange:)
                                                 name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:cloudStore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // 등록 끝의 통지 요구를 삭제
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



// 통지 처리
-(void) ubiquitousKeyValueStoreDidChange: (NSNotification *)notification
{
    
    // 통지 데이터
    NSDictionary *notifyInfo = [notification userInfo];
    
    // 갱신된 데이터의 키 값
    NSArray *keys = [notifyInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];

    //defaultStore 메소드를 사용하여 NSUbiquitousKeyValueStore 오브젝트를 구하기
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    for (NSString *key in keys) {
        // 변경이 발생한 데이터를 구하기
        NSString *value = [cloudStore stringForKey:key];
        NSLog(@"value:%@", value);
    }
    
    // 알람을 표시
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"통지"
                          message:@"iCloud의 데이터가 변경되었습니다."
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil];
    [alert show];
    
    //UITextField을 갱신
    _valueField.text = [cloudStore stringForKey:kStringKey];
}

//iCloud로의 데이터 저장
- (IBAction)saveKeyValue:(id)sender {
    
    //defaultStore 메소드를 사용하여 NSUbiquitousKeyValueStore 오브젝트를 구하기
    NSUbiquitousKeyValueStore *cloudStore = [NSUbiquitousKeyValueStore defaultStore];
    
    //NSUbiquitousKeyValueStore 오브젝트로 데이터를 저장
    [cloudStore setString:_valueField.text forKey:kStringKey];
    
    //iCloud와 싱크 시킨다
    [cloudStore synchronize];
}

@end
