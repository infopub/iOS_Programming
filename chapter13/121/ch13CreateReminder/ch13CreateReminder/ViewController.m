//
//  ViewController.m
//  ch13CreateReminder
//
//  Created by HU QIAO on 2013/11/22.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderText;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
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

//미리알림 작성 버튼을 눌렀을 때의 동작
- (IBAction)createReminder:(id)sender {
    
    // 미리알림으로의 접근 허가 상태를 확인하고, 미리알림을 표시한다
    [self checkEventStoreAccessForReminder];
    
}


// 미리알림으로의 접근 허가 상태를 확인한다
-(void)checkEventStoreAccessForReminder
{
    // 접근 허가에 대해서의 스테이터스를 구한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    
    //EKAuthorizationStatus 값에 따라서 처리한다
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       // 접근을 사용자가 허가하는 경우
        {
            // 기본 캘린더로 접근을 한다
            [self createReminder];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    // 아직 사용자가에게 접근 허가의 알림을 하지 않은 경우
        {
            // 「이 앱이 미리알림으로 접근을 요구합니다」라는 알람이 표시된다
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // 사용자가 접근을 허가한 경우
                     // 메인 스레드를 멈추지 않도록 dispatch_async를 사용하여 처리를 백그라운드에서 한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 허가되면 미리알림 작성을 한다
                         [weakSelf createReminder];
                     });
                 } else {
                     // 사용자가 접근 거부한 경우
                     // UIAlertView의 표시를 메인스레드에서 한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"확인"
                                                     message:@"이 앱의 미리알림으로의 접근을 허가하려면 개인정보보호에서 설정을 해야 합니다."
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
        case EKAuthorizationStatusRestricted:       // iPhone 설정의 일반의 「차단」에서 미리알림으로 접근을 제한한 경우
        {
            // 경고를 표시
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고"
                                                            message:@"미리알림으로의 접근을 허가하지 않았습니다."
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

// 태스크를 미리알림에 등록한다
-(void)createReminder
{
    
    // 추가할 미리알림 오브젝트를 작성한다
    EKReminder *reminder = [EKReminder
                            reminderWithEventStore:self.eventStore];
    
    // 타이틀을 설정한다
    reminder.title = _reminderText.text;
    
    // iPhone 표준의 설정 앱에서 지정한 「기본 캘린더」를 가리킨다
    reminder.calendar = [_eventStore defaultCalendarForNewReminders];
    
    
    // DatePicker에서 입력한 일시를 구한다
    NSDate *date = [_datePicker date];
    
    // Alarm을 설정한다
    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date];
    [reminder addAlarm:alarm];
    
    // 기한을 설정한다
    //  입력한 일시＋１시간
    reminder.dueDateComponents = [[NSCalendar currentCalendar] components: NSMinuteCalendarUnit | NSHourCalendarUnit |NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
                                                                 fromDate:[date dateByAddingTimeInterval:1*60*60]];
    
    // 미리알림을 등록
    NSError *error = nil;
    BOOL success = [_eventStore saveReminder:reminder commit:YES error:&error];
    if (!success) {
        NSLog(@"error = %@", error);
        //등록 실패한 경우
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고"
                                                        message:@"미리알림으로의 태스크를 등록이 실패했습니다."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        // 등록 성공한 경우
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"완료"
                                                        message:@"미리알림으로의 태스크를 등록했습니다."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

// 키보드를 비표시로 한다
- (IBAction)hideKeyboard:(id)sender {
    [_reminderText resignFirstResponder];
    
}


@end
