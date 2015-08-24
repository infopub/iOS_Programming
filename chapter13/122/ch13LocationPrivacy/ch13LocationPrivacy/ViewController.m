//
//  ViewController.m
//  ch13LocationPrivacy
//
//  Created by HU QIAO on 2013/11/24.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate>
{
@private
    NSDate *_startUpdatingLocationAt;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *getLocationButton;

// LocationManager 인스턴스
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // 위치 정보 서비스를 정지한다
    [self stopLocationService];
}

// 개인 정보 보호→위치 서비스의 상태 버튼을 눌렀을 때의 처리
- (IBAction)checkLocationServiceAuthorizationStatus:(id)sender {
    
    if(![CLLocationManager locationServicesEnabled])
    {
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:NSLocalizedString(@"위치 서비스가 OFF입니다.", nil)
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
    } else {
        
        // 앱 실행 후, 위치 서비스로의 접근을 허가할지 아직 선택되지 않은 상태
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"사용자에게 아직 위치 서비스의 접근 허가를 요구하지 않습니다."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        // 설정 > 일반 > 차단에서 위치 서비스의 이용을 제한한 상태
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"iPhone 설정의 「차단」에서 위치 서비스 이용을 제한한다"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        // 사용자가 이 앱에서의 위치 서비스로의 접근을 허가하지 않은 상태
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"사용자가 이 앱에서 위치 서비스로의 접근을 허가하지 않는다"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        // 사용자가 이 앱에서 위치 서비스로의 접근을 허가한 상태
        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"사용자가 이 앱에서의 위치 서비스로의 접근을 허가한다"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}



// 위치 정보 얻기 버튼을 눌렀을 때의 처리
- (IBAction)getLocation:(id)sender {
    
    // 위치 서비스의 상태를 확인한다
    if ([self checkLocationService]){

        // 위치 서비스로의 인증 상태를 확인한다
        if([self checkCLAuthorizationStatus]){
    
            // 측정 시작
            [_locationManager startUpdatingLocation];
            
            _getLocationButton.enabled = NO;
            _startUpdatingLocationAt = [NSDate date];
        };
    }
}

// 위치 서비스를 정지한다
- (void)stopLocationService
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;

}

// 위치 서비스의 상태를 확인한다
-(BOOL) checkLocationService
{
    if(![CLLocationManager locationServicesEnabled])
    {
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:NSLocalizedString(@"위치 서비스를 ON으로 하세요.", nil)
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        return  NO;
    }
    return YES;
}


// 위치 서비스로의 인증 상태를 확인한다
-(BOOL)checkCLAuthorizationStatus
{
    // 이 앱의 위치 서비스로의 인증 상태를 구한다
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    switch (status) {
        case kCLAuthorizationStatusAuthorized:
        // 위치 서비스로의 접근이 허가되었다
        case kCLAuthorizationStatusNotDetermined:
        // 앱 실행 후, 위치 서비스로의 접근 허가 여부를 아직 선택하지 않은 상태
        {
            // 위치 서비스로의 접근 허가 여부를 확인하는 다이얼로그를 표시한다
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            [self.locationManager startUpdatingLocation];
            _getLocationButton.enabled = NO;
            _startUpdatingLocationAt = [NSDate date];
        }
            return YES;
        case kCLAuthorizationStatusRestricted:
        // 설정 > 일반 > 차단에서 위치 서비스의 이용을 제한한다
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"차단으로 위치 서비스의 이용을 제한한다", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            _getLocationButton.enabled = YES;
        }
            return NO;
        case kCLAuthorizationStatusDenied:
        // 사용자가 이 앱으로 위치 서비스로의 접근을 허가하지 않는다
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"사용자가 이 앱으로의 위치 서비스로 접근을 허가하지 않는다", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            _getLocationButton.enabled = YES;
        }
            return NO;
        default:
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"위치 서비스의 인증 정보를 구할 수 없다", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            _getLocationButton.enabled = YES;
        }
            return NO;
    }
}


// 위치 정보가 갱신된 때, 이 델리게이터 메소드가 호출된다
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *recentLocation = locations.lastObject;
    if (recentLocation.timestamp.timeIntervalSince1970 < _startUpdatingLocationAt.timeIntervalSince1970) {
        return;
    }
    
    [_locationManager stopUpdatingLocation];
    
    _getLocationButton.enabled = YES;
    
    //MapView를 갱신
    [_mapView setCenterCoordinate:recentLocation.coordinate animated:YES];
    
    MKPointAnnotation *mapAnnotation = [[MKPointAnnotation alloc] init];
    mapAnnotation.coordinate = recentLocation.coordinate;
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:mapAnnotation];
    
}

// 측정 실패한 경우는 이 델리게이트 메소드가 호출된다
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLocationService];
    
    _getLocationButton.enabled = YES;

    [[[UIAlertView alloc] initWithTitle:nil
                                message:NSLocalizedString(@"측정에 실패 했습니다.", nil)
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}


// 위치 서비스 설정이 변경된 경우, 이 델리게이트가 호출된다
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusRestricted:
        // 차단에 위치 서비스의 이용을 「오프」에서 변경할 수 없도록 한 경우
        {
            // 위치서비스를 정지한다
            [self stopLocationService];
            _getLocationButton.enabled = YES;
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"차단으로 위치 서비스의 이용을 제한한다", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
        }
            break;
        case kCLAuthorizationStatusDenied:
        // 사용자가 이 앱의 위치 서비스로의 접근 허가를 「오프」로 한 경우
        {
            // 위치 서비스를 정지한다
            [self stopLocationService];
            _getLocationButton.enabled = YES;
            [[[UIAlertView alloc] initWithTitle:nil
                                        message:NSLocalizedString(@"사용자가 이 앱에서의 위치 서비스로의 접근을 허가하지 않았습니다", nil)
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
        }
            break;
        default:
            break;
    }
}

@end
