//
//  ViewController.m
//  ch11GpsLogger
//
//  Created by j9 on 2013/12/31.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
{
    IBOutlet UITextView* textView;
    
    CLLocationManager* manager;
}
@end

@implementation ViewController

- (NSString*)now
{
    // 서식 지정으로 현재의 일시를 반환한다
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.locale     = [[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    return [formatter stringFromDate:[NSDate date]];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    textView.text = [[NSString stringWithFormat:@"[%@] %.6f %.6f %.6f\n",
                      [self now],
                      newLocation.coordinate.latitude,
                      newLocation.coordinate.longitude,
                      newLocation.altitude] stringByAppendingString:textView.text];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // 위치 정보 취득 실패 시의 처리
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 위치 정보 서비스의 이용 확인
    if ([CLLocationManager locationServicesEnabled]) {
        manager = [[CLLocationManager alloc] init];
        
        // 통지 이벤트를 이 클래스에서 받는다
        manager.delegate = self;
        
        // 최고 정밀도를 설정
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        // 이동 거리가 변화할 때에 이벤트를 일으키는 값(미터)을 지정、kCLDistanceFilterNone으로 차례대로
        manager.distanceFilter = kCLDistanceFilterNone;
        
        // 위치 정보 취득 자동 정지 무효
        manager.pausesLocationUpdatesAutomatically = NO;
        
        // 위치 정보 취득 시작
        [manager startUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (manager != nil) {
        [manager stopUpdatingLocation];
    }
}

@end
