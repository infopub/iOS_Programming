//
//  ViewController.m
//  ch13CalendarPrivacy
//
//  Created by HU QIAO on 2013/11/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <EventKitUI/EventKitUI.h>
#import <EventKit/EventKit.h>
#import "ViewController.h"

@interface ViewController ()  <EKEventEditViewDelegate>

// EKEventStore 인스턴스
@property (nonatomic, strong) EKEventStore *eventStore;
// 달력 인스턴스
@property (nonatomic, strong) EKCalendar *calendar;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // EKEventStore를 초기화한다
	self.eventStore = [[EKEventStore alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 개인 정보 보호→달력의 상태 버튼을 누를 때의 처리
- (IBAction)checkCalendarAuthorizationStatus:(id)sender {
    
    // 접근 허가에 대한 상태를 구한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    // 사용자에게 아직 접근 허가를 요구하지 않은 경우
    if(status == EKAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"사용자에게 아직 접근 허가를 요구하지 않는다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    //iPhone 설정의 「차단」에서 달력으로의 접근을 제한한 경우
    else if(status == EKAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"iPhone 설정의 「차단」에서 달력으로의 접근을 제한한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 달력으로의 접근을 사용자가 거부한 경우
    else if(status == EKAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"달력으로의 접근을 사용자가 거부한다 "
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 달력으로의 접근을 사용자가 허가한 경우
    else if(status == EKAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"달력으로의 접근을 사용자가 허가한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

// 이벤트 표시 버튼을 누를 때의 처리
- (IBAction)showEventView:(id)sender {
    
    
    // 접근 허가에 대해서의 상태를 구한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    //EKAuthorizationStatus 값에 따라서 처리한다
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       // 액세스를 사용자가 허가한 경우
        {
            // 기본 달력으로의 접근을 한다
            [self showEKEventEditView];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    // 아직 사용자에게 접근 허가의 알림을 알리지 않은 상태
        {
            // 「이 앱이 달력으로의 접근을 요구합니다」라고 한 알림이 표시된다
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // 사용자가 접근을 허가한 경우
                     // 메인 스레드를 멈추기 위하여 dispatch_async를 사용해서 처리를 백그라운드에서 실행한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 허가되면 기본 달력으로의 접근을 한다
                         [weakSelf showEKEventEditView];
                     });
                 } else {
                     // 사용자가 접근 거부한 경우
                     // UIAlertView의 표시를 메인스레드에서 실행한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"확인"
                                                     message:@"이 앱 달력으로의 접근을 허가하려면 개인 정보 보호에서 설정해야 한다."
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
        case EKAuthorizationStatusRestricted:       //iPhone 설정의 「차단」에서 달력으로의 접근을 제한한 경우
        {
            // 알람을 표시
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고"
                                                            message:@"달력으로의 접근을 허가하지 않는다."
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

// 이벤트 등록 화면을 표시한다
-(void)showEKEventEditView
{
    // iPhone 표준의 설정 앱에서 지정한 「기본 달력」을 가리킨다.
    self.calendar = self.eventStore.defaultCalendarForNewEvents;
    
    // 이벤트 등록 화면에 표시하는 내용을 지정한다
    EKEvent *event = [EKEvent eventWithEventStore:_eventStore];
    
    /*이벤트 추가 화면의 작성*/
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] init];
	addController.eventStore = self.eventStore;
    addController.event = event;
    addController.editViewDelegate = self;
    
    [self presentViewController:addController animated:YES completion:nil];
}


// 이벤트 추가 화면의 처리에 대응하는 메소드
- (void)eventEditViewController:(EKEventEditViewController *)controller
		  didCompleteWithAction:(EKEventEditViewAction)action
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


// EKEventEditViewController의 처리 대상을 지정한 「기본 달력」으로 한다
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller
{
	return self.calendar;
}


@end
