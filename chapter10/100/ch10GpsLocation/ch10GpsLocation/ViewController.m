//
//  ViewController.m
//  ch10GpsLocation
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate>
{
    IBOutlet UILabel* longitude;
    IBOutlet UILabel* latitude;
    IBOutlet UILabel* altitude;

    IBOutlet UILabel* speed;
    
    CLLocationManager* manager;
}
@end

@implementation ViewController

- (IBAction)stop:(UIButton*)sender
{
    if (manager != nil) {
        [manager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    latitude.text  = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.latitude];
    longitude.text = [NSString stringWithFormat:@"%.6f", newLocation.coordinate.longitude];
    altitude.text  = [NSString stringWithFormat:@"%.6f", newLocation.altitude];
    
    speed.text     = [NSString stringWithFormat:@"%.2f m/s", newLocation.speed];
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

    // 위치 정보 서비스의 이용 확인
    if ([CLLocationManager locationServicesEnabled]) {
        manager = [[CLLocationManager alloc] init];
 
        // 통지 이벤트를 이 클래스에서 받는다
        manager.delegate = self;
        
        // 최고 정밀도를 설정
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
        // 이동 거리가 변환했을 때에 이벤트를 일으키는 값(미터)를 설정、kCLDistanceFilterNone으로 차례대로
        manager.distanceFilter = kCLDistanceFilterNone;
        
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
    [self stop:nil];
}

@end
