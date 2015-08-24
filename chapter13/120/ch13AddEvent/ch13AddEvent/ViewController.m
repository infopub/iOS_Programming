//
//  ViewController.m
//  ch13AddEvent
//
//  Created by HU QIAO on 2013/11/21.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "ViewController.h"

@interface ViewController () <EKEventEditViewDelegate>

// EKEventStore 인스턴스
@property (nonatomic, strong) EKEventStore *eventStore;
// 캘린더 인스턴스
@property (nonatomic, strong) EKCalendar *calendar;
// 처리 결과 메세지를 나타내는 라벨
@property (weak, nonatomic) IBOutlet UILabel *feedbackMsg;

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


// 이벤트 추가 버튼을 눌렀을 때의 처리
- (IBAction)addEvent:(id)sender {
    
    // 캘린더 정보로의 액세스 허가 상태를 확인하고, 이벤트 등록화면을 표시한다
    [self checkEventStoreAccessForCalendar];
    
}

// 캘린더 정보로의 액세스 허가 상태를 확인한다
-(void)checkEventStoreAccessForCalendar
{
    // 액세스 허가에 대한 스테이터스를 취득한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    // EKAuthorizationStatus의 값에 따라서 처리한다
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       // 액세스를 사용자가 허가하는 경우
        {
            // 기본 캘린더로의 액세스를 한다
            [self addEventToCalendar];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    // 아직 사용자에게 액세스 허가의 알람을 알리지 않은 상태
        {
            // 「이 앱이 캘린터로의 액세스를 하려 합니다」 라는 알람을 표시
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // 사용자가 액세스를 허가한 경우
                     // 메인스레드를 중지하지 않기 위해서 dispatch_async를 사용해 처리를 백그라운드로 실행
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 허가했다면 기본 캘린더로의 액세스를 실행
                         [weakSelf addEventToCalendar];
                     });
                 } else {
                     // 사용자가 액세스를 불허한 경우
                     // UIAlertView의 표시를 메인스레드에서 실행
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"확인"
                                                     message:@"이 앱의 캘린더의 액세스를 허가하려면, 프라이버시로부터 설정해야 합니다."
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil]
                          show];
                     });
                 }
             }];
            
        }
            break;
        case EKAuthorizationStatusDenied:           // 액세스를 사용사로부터 거부당한 경우
        case EKAuthorizationStatusRestricted:       // iPhone 설정의 「기능제한」에서 캘린더의 액세스를 제한하고 있는 경우
        {
            // 알람을 표시
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고"
                                                            message:@"캘린더에 액세스가 허가되지 않습니다."
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

// 이벤트 추가 화면(EKEventEditViewController)을 표시할 메소드
-(void)addEventToCalendar
{
    
    // 추가할 이벤트 객체를 작성
    EKEvent *event = [EKEvent eventWithEventStore:_eventStore];
    // 타이틀
    event.title = @"iOS 개발자 모임";
    // 장소
    event.location = @"SDC COMPANY";
    // 시작시간
    event.startDate = [NSDate date];
    // 종료시간 86400초 준비
    event.endDate = [NSDate dateWithTimeIntervalSinceNow:86400];
    // 메모
    event.notes = @"노트북 지참";
    
    // 이벤트 추가 화면을 작성
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] init];

    // 이벤트 객체를 이벤트 추가 화면에 전달
    addController.event = event;

	// 이벤트 스토아를 이벤트 추가 화면에 전달
    addController.eventStore = self.eventStore;
    
    // 추가 통지를 수실할 델리게이트를 설정
    addController.editViewDelegate = self;
    
    // 이벤트 추가 화면을 모달 화면으로 표시
    [self presentViewController:addController animated:YES completion:nil];
}


// EKEventEditViewController의 처리대상을 지정한 「기본 캘린더」로 한다
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller
{
    // iPhone 표준 설정 앱으로 지정한 「기본 캘린더」를 지정
    self.calendar = self.eventStore.defaultCalendarForNewEvents;
    
	return self.calendar;
}

// 사용자가 이벤트 추가화면을 종료했을 떄 통지를 받기위한 델리게이트
// 모달 모드의 View Controller를 닫고 eventEditViewController:didCompleteWithAction: 메소드 구현
- (void)eventEditViewController:(EKEventEditViewController *)controller
		  didCompleteWithAction:(EKEventEditViewAction)action
{
    ViewController * __weak weakSelf = self;
    weakSelf.feedbackMsg.hidden = NO;
    
    // 모달 이벤트 추가 화면을 닫음
    [self dismissViewControllerAnimated:YES completion:^
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSError *error = nil;
             switch (action) {
                 case EKEventEditViewActionCanceled:
                     // 취소 버튼을 눌렀을 때
                     weakSelf.feedbackMsg.text = @"이벤트 등록이 취소되었습니다.";
                     break;
                 case EKEventEditViewActionSaved:
                 {
                     // 완료 버튼을 눌렀을 떄
                     [controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
                     weakSelf.feedbackMsg.text = @"이벤트가 등록되었습니다.";
                 }
                     break;
                 default:
                     break;
             }
         });
     }];
}



@end
