//
//  ViewController.m
//  GoogleMapRecipe
//
//  Created by Mika Yamamoto on 2014/02/17.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController ()

@end

@implementation ViewController{
    GMSMapView *mapView_;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// 보통은 뷰를 로드할 때에 설정을 추가한다.
    // GMSCameraPosition을 작성
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    // Set the mapType to Satellite
    mapView_.mapType = kGMSTypeTerrain;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
