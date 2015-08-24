//
//  ViewController.m
//  ch9UseMapKitPin
//
//  Created by shoeisha on 2014/01/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 표시 좌표
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(37.566477, 126.977985);

    // 핀용 어노테이션을 생성
    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = loc;   // 핀 좌표
    
    // 핀을 설정
    [self.mapView addAnnotation:pin];

    // 표시 위치와 크기를 설정
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(loc, span);
    [self.mapView setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
