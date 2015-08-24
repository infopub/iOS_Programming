//
//  AppDelegate.m
//  ch15database
//
//  Created by SHOEISHA on 2014/01/08.
//  Copyright (c) 2014年 SHOEISHA. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *controller = (MasterViewController *)navigationController.topViewController;

    // 디렉터리 목록을 취득한다
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths[0];
    NSString *databaseFilePath = [documentDirectory stringByAppendingPathComponent:@"ch15database.db"];
    // 인스턴스를 작성한다
    _database = [FMDatabase databaseWithPath:databaseFilePath];
    // 데이터베이스를 오픈한다
    [_database open];

    // 테이블에 존재하는지 확인한다
    FMResultSet *results = [_database executeQuery:@"SELECT 1 FROM sqlite_master WHERE type = 'table' AND name = 'stations';"];
    // 테이블이 존재하면 계속 진행
    if (![results next]) {
        // 트랜잭션을 시작
        // 테이블을 작성한다
        [_database beginTransaction];
        [_database executeUpdate:@"CREATE TABLE stations (sid INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, distance REAL, memo TEXT);"];
        // 초기 데이터를 추가한다.
        NSArray *stations = @[
                              @[@"신도림", @0.0,@"기점역"],
                              @[@"대림", @2.0,@"7호선 환승"],
                              @[@"구로디지터단지", @4.0,@"車庫"],
                              @[@"신대방역", @6.0,@"보라매공원"],
                              @[@"신림역", @8.0,@"관악산"],
                              @[@"서울대입구역", @10.0,@"서울대"],
                              @[@"낙성대입구역", @12.0,@"낙성대"],
                              @[@"사당역", @14.0,@"4호선 환승"],
                              @[@"방배역", @16.0,@"주택가"],
                              @[@"서초역", @18.0,@"법원"],
                            ];
        for (NSArray *station in stations) {
            [_database executeUpdate:@"INSERT INTO stations(name, distance, memo) VALUES (?, ?, ?);", station[0], station[1], station[2]];
        }
        // 트랜잭션을 커밋한다
        [_database commit];
    }
    controller.database = _database;
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
    // 데이터베이스를 닫음
    [_database close];
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
