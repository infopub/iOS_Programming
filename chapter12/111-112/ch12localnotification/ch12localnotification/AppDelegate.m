//
//  AppDelegate.m
//  ch12localnotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UILocalNotification *notification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification) {
        // 로컬 통지가 있는 경우, 그것을 처리한다
        [self application:application didReceiveLocalNotification:notification];
    }
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // 화면을 갱신한다
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    if (self.window.rootViewController) {
        [viewController showRemain];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
    // 통지를 받은 때에 호출되는 처리
    // 애플리케이션이 액티브 시에 통지가 발생할 때 호출되는 외, 통지 센터에서 과거의 통지가 호출된 때도 발생한다.
    
    // 통지를 받은 것을 표시한다
    NSString *registered = notification.userInfo[@"registered"];
    self.message = [NSString stringWithFormat:@"%@의 로컬 통지가 호출되었습니다.", registered];
    
    // 통지를 취소함으로써 통지 센터에서 삭제한다
    [[UIApplication sharedApplication] cancelLocalNotification:notification];

    // 화면을 갱신한다
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    if (self.window.rootViewController) {
        [viewController showRemain];
    }
}

@end
