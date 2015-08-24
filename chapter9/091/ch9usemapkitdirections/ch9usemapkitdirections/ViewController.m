//
//  ViewController.m
//  ch9UseMapKitDirections
//
//  Created by shoeisha on 2014/01/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 표시 위치를 지정
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(37.56544,126.977119);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.02, 0.02);
    self.mapView.region = MKCoordinateRegionMake(loc, span);
    
    // 서울시청
    CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(37.56544, 126.977119);
    
    // 경복궁
    CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake(37.579423, 126.977236);
    
    // 핀을 표시
    MKPointAnnotation *pin1 = [[MKPointAnnotation alloc] init];
    pin1.coordinate = loc1;
    [self.mapView addAnnotation:pin1];
    MKPointAnnotation *pin2 = [[MKPointAnnotation alloc] init];
    pin2.coordinate = loc2;
    [self.mapView addAnnotation:pin2];
    
    
    // 좌표에서 MKPlacemark를 생성
    MKPlacemark *mark1 = [[MKPlacemark alloc] initWithCoordinate:loc1 addressDictionary:nil];
    MKPlacemark *mark2   = [[MKPlacemark alloc] initWithCoordinate:loc2 addressDictionary:nil];
    
    // MKPlacemark에서 MKMapItem을 생성
    MKMapItem *item1 = [[MKMapItem alloc] initWithPlacemark:mark1];
    MKMapItem *item2   = [[MKMapItem alloc] initWithPlacemark:mark2];
    
    // MKMapItem을 설정하고 MKDirectionsRequest를 생성
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = item1;
    request.destination = item2;
    request.transportType = MKDirectionsTransportTypeWalking; // 도보를 지정
    request.requestsAlternateRoutes = NO;
    
    // MKDirectionsRequest에서 MKDirections를 생성
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    // 경로 검색을 실행
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             return;
         }
         
         if ([response.routes count] > 0) {
             MKRoute *route = [response.routes objectAtIndex:0];
             // 경로를 그리기
             [self.mapView addOverlay:route.polyline];
         }
     }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        // 경로를 나타내는 선의 굵기
        routeRenderer.lineWidth = 3.0;
        // 경로를 나타내는 선의 색 지정
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
    } else {
        return nil;
    }
}

@end
