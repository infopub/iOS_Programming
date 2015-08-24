//
//  ViewController.m
//  ch12localnotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)showRemain
{
    // 남은 로컬 통지수를 표시한다
    NSArray *localNotificaions = [UIApplication sharedApplication].scheduledLocalNotifications;
    self.remainLabel.text = [NSString stringWithFormat:@"나머지： %ld", (long)localNotificaions.count];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.messageLabel.text = appDelegate.message;

    // 애플리케이션의 배지에도 나머지 개수를 표시
    // 이 샘플에서는 배지에 "아직 일어나지 않은 통지의 수"를 표시하지만 실제 어플리케이션에서는
    // "미확인의 통지의 수"를 표시하도록 한다
    [UIApplication sharedApplication].applicationIconBadgeNumber = localNotificaions.count;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self showRemain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 버튼이 눌렸다
- (IBAction)createLocalNotificationButtonDidPush:(id)sender
{
    // 지금까지 작성한 통지의 라벨을 ＋１한다
    for (UILocalNotification *notification in [UIApplication sharedApplication].scheduledLocalNotifications) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        if (notification.applicationIconBadgeNumber <= 0) {
            // 배지 번호가 0이하인 경우는 1로 변경한다
            notification.applicationIconBadgeNumber = 1;
        } else {
            // 그 외의 경우는 +1한다
            notification.applicationIconBadgeNumber++;
        }
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmssS";
    NSString *registered = [formatter stringFromDate:[NSDate date]];
    
    // 30초 후에 통지를 한다
    UILocalNotification *notification = [UILocalNotification new];
    notification.timeZone = [NSTimeZone defaultTimeZone];   // 통지 시각의 타임존
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];   // 통지시각
    notification.repeatInterval = 0;    // 통지의 반복 간격
    notification.repeatCalendar = nil;  // 재통지 간격
    // 통지 시에 표시되는 문자열. 생략한 경우, 통지 메세지가 표시되지 않는다
    notification.alertBody = [NSString stringWithFormat:@"[%@]의 통지가 발생했습니다.", registered];
    // 통지 시에 표시되는 버튼의 이름
    // 통지에 사용하는 음성 파일. 통지에 사용한 음성 파일. 파일은 리니어 PCM, MA4, aLaw 또는 μ Law의 aiff, wav, caf형식으로 30초 이내로 하여 메인 번들에 포함하여 둔다.
    // UILocalNotificationDefaultSoundName로 하면 시스템의 기본음이 사용된다.
    // nil을 설정한 경우는 음이 울리지 않는다.
    notification.soundName = UILocalNotificationDefaultSoundName;
    //
    notification.applicationIconBadgeNumber = -1;   // 배지를 지운다（0인 경우는 화면 위의 배지수는 변경되지 않기 때문에）
    notification.userInfo = @{@"registered": registered};
    notification.alertAction = @"App에서 본다";
    notification.hasAction = YES;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.message = [NSString stringWithFormat:@"%@의 통지가 작성되었습니다.", registered];
    [self showRemain];
}

@end
