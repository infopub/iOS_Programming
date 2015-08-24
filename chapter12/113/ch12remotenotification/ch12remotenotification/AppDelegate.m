//
//  AppDelegate.m
//  ch12remotenotification
//
//  Created by SHOEISHA on 2013/12/29.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
{
    BOOL notificationIsShown;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 리모트 통지를 받도록 설정
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    
    NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        // 리모트 통지가 발생했다
        [self application:application didReceiveRemoteNotification:userInfo];
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // 리모트 통지가 있었을 경우에 발생
    self.message = [@"리모트 통지가 발생했습니다.\n" stringByAppendingString:[userInfo description]];
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    viewController.messageTextView.text = self.message;
    notificationIsShown = YES;
    // 통지 센터에서 리모트 통지를 삭제한다
    application.applicationIconBadgeNumber = 0;
    [application cancelAllLocalNotifications];
}

// 리모트 통지의 등록에 성공
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 통지를 기존에 표시한 경우는 디바이스 토큰을 표시하지 않도록 한다
    if (!notificationIsShown) {
        // 취득한 디바이스 토큰을 16진수로 변환
        NSUInteger length = deviceToken.length;
        NSMutableString *deviceTokenString = [NSMutableString stringWithCapacity:length * 2];
        const char *deviceTokenBytes = [deviceToken bytes];
        for(int i = 0; i < length; i++) {
            [deviceTokenString appendFormat:@"%02.2hhX", deviceTokenBytes[i]];
        }
        self.message = [NSString stringWithFormat:@"이 디바이스의 디바이스 토큰은 %@입니다.\n리모트 통지가 발생하면 메시지를 표시합니다.", deviceTokenString];
        ViewController *viewController = (ViewController *)self.window.rootViewController;
        viewController.messageTextView.text = self.message;
    }
}

// 리모트 통지의 등록에 실패
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    self.message = [NSString stringWithFormat:@"리모트 통지로의 등록에 실패했기 때문에 리모트 통지를 받을 수 없습니다. \n에러코드 %ld (%@)", (long)[error code], [error localizedDescription]];
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    viewController.messageTextView.text = self.message;
}

@end
