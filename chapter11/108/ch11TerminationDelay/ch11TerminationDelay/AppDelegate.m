//
//  AppDelegate.m
//  ch11TerminationDelay
//
//  Created by shoeisha on 2013/12/15.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//
/*
 * https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/ManagingYourApplicationsFlow/ManagingYourApplicationsFlow.html
 *
 *
 */

#import "AppDelegate.h"

@interface AppDelegate ()
{
    UIBackgroundTaskIdentifier bgTask;
    NSDate* startTime;
}
@end

@implementation AppDelegate

- (NSString*)now
{
    // 서식 지정으로 현재의 일시를 반환한다
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    return [formatter stringFromDate:[NSDate date]];
}

- (void)addNotification:(NSString*)body afterSeconds:(NSTimeInterval)seconds withSound:(NSString*)soundName
{
    // 통지 오브젝트를 생성하고 파라미터 설정
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    notification.alertBody = body;
    notification.soundName = soundName;
    
    // 애플리케이션에 전달
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (void)notificate:(NSString*)message
{
    NSTimeInterval duration = -[startTime timeIntervalSinceNow];

    [self addNotification:[NSString stringWithFormat:@"%.fsec : %@", duration, message]
             afterSeconds:0
                withSound:nil];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self notificate:@"백그라운드 처리 시작"];
    
    startTime = [NSDate date];
    
    UIApplication* app = [UIApplication sharedApplication];
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        
        [self notificate:@"백그라운드 작업 시간 초과"];
        
        // 백그라운드 중지
        if (bgTask != UIBackgroundTaskInvalid) {
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        }
    }];
    
    // 백그라운드 처리
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 여기서부터 임의로 백그라운드 처리하고 싶은 것을 기술
        while (bgTask != UIBackgroundTaskInvalid) {
            [self notificate:@"백그라운드 처리 중"];
            [NSThread sleepForTimeInterval:1];
        }
        // 여기까지
        
        [self notificate:@"백그라운드 처리 종료"];
        
        // 백그라운드 중지
        if (bgTask != UIBackgroundTaskInvalid) {
            [app endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
        }
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    // 백그라운드 정지
    if (bgTask != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
