//
//  AppDelegate.m
//  iOSRecipe_17_02
//
//  Copyright (c) 2014 shimy. All rights reserved.
//

#import "AppDelegate.h"

// CocoaLumberjack 헤더 파일 임포트
#import "DDTTYLogger.h"
#import "DDASLLogger.h"

// CocoaLumberjack 로그 출력 레벨을 설정
static const int ddLogLevel = LOG_LEVEL_DEBUG;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // CocoaLumberjack 로그 출력 장소를 설정
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // Xcode의 콘솔에 로그를 출력
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // 애플의 시스템 로거에 송신
    
    // CocoaLumberjack 로그 출력 실행
    DDLogError(@"Error");      // 에러인 경우
    DDLogWarn(@"Warn");        // 경고인 경우
    DDLogInfo(@"Info");        // 정보인 경우
    DDLogDebug(@"Debug");      // 디버그인 경우
    DDLogVerbose(@"Verbose");  // 자세한 디버그인 경우

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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
