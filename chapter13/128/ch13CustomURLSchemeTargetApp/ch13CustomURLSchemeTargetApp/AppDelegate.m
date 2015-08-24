//
//  AppDelegate.m
//  ch13CustomURLSchemeTargetApp
//
//  Created by HU QIAO on 2013/12/08.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate()

@property (strong, nonatomic) ViewController *viewController;

@end

@implementation AppDelegate



// 앱이 아직 실행되지 않은 경우에는 didFinishLaunchingWithOptions와 openURL이 계속해서 호출된다.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.viewController = [storyBoard instantiateViewControllerWithIdentifier:@"MyViewController"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
	if (launchOptions) {
		
		[self.viewController showMessage:@"didFinishLaunchingWithOptions was called:\n\n"];
        
        //URL 스킴으로 실행된 경우, 「launchOptions」 의 키：「UIApplicationLaunchOptionsURLKey」에는 호출된 URL이 저장된다.
		NSURL *launchURL = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
		[self.viewController showMessage:[launchURL description]];
        
    }
	
    return YES;
}

// 앱 자신이 기존에 실행된 경우에는 openURL만이 호출된다.
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
 
        
	[self.viewController showMessage:@"\n\nopenURL was called:\n\n"];

    NSString* strUrl = [NSString stringWithFormat:@"url:\n%@\n\n",[url description]];
	[self.viewController showMessage:strUrl];

    
	NSString* strSrcApp = [NSString stringWithFormat:@"sourceApplication:\n%@\n\n",sourceApplication];
	[self.viewController showMessage:strSrcApp];
	
	NSString* strAnnotation = [NSString stringWithFormat:@"annotation:\n%@\n\n",[annotation description]];
	[self.viewController showMessage:strAnnotation];
	
	return YES;
	
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    
    ;;
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    ;
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
