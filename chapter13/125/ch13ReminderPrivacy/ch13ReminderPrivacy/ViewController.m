//
//  ViewController.m
//  ch13ReminderPrivacy
//
//  Created by HU QIAO on 2013/11/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//


#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "ViewController.h"

@interface ViewController ()

// EKEventStore 인스턴스
@property (nonatomic, strong) EKEventStore *eventStore;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // EKEventStore을 초기화한다
    self.eventStore = [[EKEventStore alloc] init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 개인 정보 보호→미리 알림 상태 버튼을 누를 때의 처리
- (IBAction)checkReminderAuthorizationStatus:(id)sender {

    // 접근 허가에 대한 상태를 구한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    // 사용자에게 아직 접근 허가를 요구하지 않는 경우
    if(status == EKAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개이니 정보 보호 상태"
                                                        message:@"사용자에게 아직 접근 허가를 요구하지 않는다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //iPhone 설정의 「차단」에서 미리알림으로의 접근을 제어하는 경우
    else if(status == EKAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"iPhone 설정의 「차단」에서 미리알림으로의 접근을 제한한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 미리알림으로의 접근을 사용자가 거부한 경우
    else if(status == EKAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"미리 알림으로의 접근을 사용자가 거부한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 미리알림으로의 접근을 사용자가 허가하는 경우
    else if(status == EKAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"미리알림으로의 접근을 사용자가 허가한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (IBAction)showReminder:(id)sender {
    
    // 접근 허가에 대한 상태를 구한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    
    //EKAuthorizationStatus 값에 따라서 처리한다
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       // 접근을 사용자가 허가한 경우
        {
            // 기본 달력으로의 접근을 한다
            [self doingSomethingWithReminder];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    // 아직 사용자에게 접근 허가의 알림을 하지 않은 상태
        {
            // 「이 앱이 미리알림으로의 접근을 요구합니다」라고 한 알림이 표시된다
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // 사용자가 접근을 허가한 경우
                     // 메인 스레드를 멈추기 위하여 dispatch_async를 사용하여 처리를 백그라운드에서 한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 허가되면 EKEntityTypeReminder로의 접근을 한다
                         [weakSelf doingSomethingWithReminder];
                     });
                 } else {
                     // 사용자가 접근 거부한 경우
                     // UIAlertView의 표시를 메인 스레드에서 한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"확인"
                                                     message:@"이 앱의 미리알림으로의 접근을 허가하려면 개인 정보 보호에서 설정해야 한다."
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil]
                          show];
                     });
                 }
             }];
            
        }
            break;
        case EKAuthorizationStatusDenied:           // 접근을 사용자가 거부한 경우
        case EKAuthorizationStatusRestricted:       //iPhone 설정의 「차단」에서 미리알림으로의 접근을 제한한 경우
        {
            // 알림을 표시
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고"
                                                            message:@"미리알림으로의 접근을 허가되지 않았습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }

}

// 미리알림을 조작한다
-(void)doingSomethingWithReminder
{
    
    [[[UIAlertView alloc] initWithTitle:@"확인"
                                message:@"미리알림 조작 처리를 실행할 수 있다."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil]
     show];

}


@end
