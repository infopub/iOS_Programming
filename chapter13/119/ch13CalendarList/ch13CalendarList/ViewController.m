//
//  ViewController.m
//  ch13CalendarList
//
//  Created by HU QIAO on 2013/11/20.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "ViewController.h"

@interface ViewController () < UITableViewDelegate,UITableViewDataSource>

// 테이블뷰
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// EKEventStore 인스턴스
@property (nonatomic, strong) EKEventStore *eventStore;
// 캘린더 인스턴스
@property (nonatomic, strong) EKCalendar *calendar;
// 이벤트 리스트
@property (nonatomic, strong) NSMutableArray *eventsList;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //　테이블 뷰를 설정한다
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // EKEventStore를 초기화한다
	self.eventStore = [[EKEventStore alloc] init];
    
    // 이벤트 리스트를 초기화한다
	self.eventsList = [[NSMutableArray alloc] initWithCapacity:0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 캘린더로의 접근 허가 상태를 확인한다
    [self checkEventStoreAccessForCalendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 테이블 행수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.eventsList.count;
}

// 행에 표시하는 데이터
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 식별명으로 셀을 찾는다
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    
    // 이벤트 타이틀을 행에 표시한다
    cell.textLabel.text = [[self.eventsList objectAtIndex:indexPath.row] title];
    
    return cell;
}


// 캘린더로의 액세스 허가 상태를 확인한다
-(void)checkEventStoreAccessForCalendar
{
    // 액세스 허가에 대한 상태를 취득한다
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    // EKAuthorizationStatus의 값에 따라서 처리한다
    switch (status)
    {
        case EKAuthorizationStatusAuthorized:       // 액세스를 사용자가 허가하고 있는 경우
        {
            // 기본 캘린더로의 액세스를 실시한다
            [self accessGrantedForCalendar];
        }
            break;
        case EKAuthorizationStatusNotDetermined:    // 아직 사용자에게 액세스 허가 알람을 하지 않은 상태
        {
            // 「이 앱이 캘린더로의 액세스를 요구합니다」라고 하는 알람이 표시된다
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
             {
                 __weak id weakSelf = self;
                 if (granted) {
                     // 사용자가 액세스를 허가한 경우
                     // 메인스레드를 멈출 수 없기 때문에 dispatch_async를 사용하여 백그라운드에서 실시한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // 허가되면 기본 캘린더로의 액세스를 실시한다
                         [weakSelf accessGrantedForCalendar];
                     });
                 } else {
                     // 사용자가 액세스 거부한 경우
                     // UIAlertView의 표시를 메인 스레드로 실시한다
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [[[UIAlertView alloc] initWithTitle:@"확인"
                                                     message:@"이 앱의 캘런더로의 액세스를 허가하라면 개인정보 보호에서 설정해야 합니다."
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil]
                          show];
                     });
                 }
             }];
            
        }
            break;
        case EKAuthorizationStatusDenied:           // 액세스를 사용자가 거부한 경우
        case EKAuthorizationStatusRestricted:       // iPhone 설정의 「일반」 -> 「차단」으로 캘린더로의 액세스를 제한하는 경우
        {
            //알람을 표시
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고"
                                                            message:@"캘린더로의 액세스를 허가하지 않습니다."
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


// 기본 캘린더의 이벤트를 얻고, 테이블 뷰를 갱신한다
-(void)accessGrantedForCalendar
{
    // 읽을 대상 캘린더를 지정한다
    //iPhone 표준의 설정 앱에서 지정한 「기본 캘린더」를 가리킨다.
    self.calendar = self.eventStore.defaultCalendarForNewEvents;
    // 1일 전부터 2일 후까지의 이벤트를 검색하고, eventsList에 설정한다
    self.eventsList = [self fetchDefaultEvents];
    // 테이블 뷰를 갱신한다
    [self.tableView reloadData];
}


//1일 전부터 2일 후까지의 기본 캘린더의 이벤트를 검색한다
- (NSMutableArray *)fetchDefaultEvents
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //1일 전
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    //2일 후
    NSDateComponents *oneDayAfterComponents = [[NSDateComponents alloc] init];
    oneDayAfterComponents.day = 2;
    NSDate *oneDayAfter = [calendar dateByAddingComponents:oneDayAfterComponents
                                                    toDate:[NSDate date]
                                                   options:0];
    
    
	// 읽을 대상 캘린더에 설정되어 있는 이벤트의 검색을 지정한다
	NSArray *calendarArray = [NSArray arrayWithObject:self.calendar];
    
    // 이벤트를 검색하기 위해서 NSPredicate 오브젝트를 작성한다
	NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:oneDayAgo
                                                                      endDate:oneDayAfter
                                                                    calendars:calendarArray];
	
    // 이벤트를 검색한다
	NSMutableArray *events = [NSMutableArray arrayWithArray:[self.eventStore eventsMatchingPredicate:predicate]];
    
    // 이벤트 프로퍼티를 구한다
	for ( EKEvent * event in events ) {
        NSLog(@"EKEvent");
        NSLog(@"Title: %@, Start Date: %@, End Date: %@, Location: %@", event.title, event.startDate, event.endDate, event.location);
        NSLog(@"EKCalendarItem");
        NSLog(@"Calendar Title: %@, Calendar Source Type: %u", event.calendar.title, event.calendar.source.sourceType);
    }
    
	return events;
}

@end
