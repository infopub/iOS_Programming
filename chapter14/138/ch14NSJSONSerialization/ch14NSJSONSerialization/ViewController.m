//
//  ViewController.m
//  ch14NSJSONSerialization
//
//  Created by HU QIAO on 2013/12/11.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jsonParse:(id)sender {
    
    // 송신하는 리퀘스트를 생성한다
    NSString* path  = @"http://maps.googleapis.com/maps/api/geocode/json?address=seoul&sensor=false";
    NSURL* url = [NSURL URLWithString:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];

    // WebApi에서 NSData 형식으로 JSON 데이터를 구하기
    NSData* jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    // Google Geocoding API
    // https://developers.google.com/maps/documentation/geocoding/?hl=kr#JSON
    
    // 지오코딩 레스폰스（JSON 데이터）：
    //{
    //    "results" : [
    //                 {
    //                     "address_components" : [
    //                                             {
    //                                                 "long_name" : "1600",
    //                                                 "short_name" : "1600",
    //                                                 "types" : [ "street_number" ]
    //                                             },
    //                                             {
    //                                                 "long_name" : "Amphitheatre Pkwy",
    //                                                 "short_name" : "Amphitheatre Pkwy",
    //                                                 "types" : [ "route" ]
    //                                             },
    //                                             {
    //                                                 "long_name" : "Mountain View",
    //                                                 "short_name" : "Mountain View",
    //                                                 "types" : [ "locality", "political" ]
    //                                             },
    //                                             {
    //                                                 "long_name" : "Santa Clara County",
    //                                                 "short_name" : "Santa Clara County",
    //                                                 "types" : [ "administrative_area_level_2", "political" ]
    //                                             },
    //                                             {
    //                                                 "long_name" : "California",
    //                                                 "short_name" : "CA",
    //                                                 "types" : [ "administrative_area_level_1", "political" ]
    //                                             },
    //                                             {
    //                                                 "long_name" : "United States",
    //                                                 "short_name" : "US",
    //                                                 "types" : [ "country", "political" ]
    //                                             },
    //                                             {
    //                                                 "long_name" : "94043",
    //                                                 "short_name" : "94043",
    //                                                 "types" : [ "postal_code" ]
    //                                             }
    //                                             ],
    //                     "formatted_address" : "1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
    //                     "geometry" : {
    //                         "location" : {
    //                             "lat" : 37.4224764,
    //                             "lng" : -122.0842499
    //                         },
    //                         "location_type" : "ROOFTOP",
    //                         "viewport" : {
    //                             "northeast" : {
    //                                 "lat" : 37.4238253802915,
    //                                 "lng" : -122.0829009197085
    //                             },
    //                             "southwest" : {
    //                                 "lat" : 37.4211274197085,
    //                                 "lng" : -122.0855988802915
    //                             }
    //                         }
    //                     },
    //                     "place_id" : "ChIJ2eUgeAK6j4ARbn5u_wAGqWA",
    //                     "types" : [ "street_address" ]
    //                 }
    //                 ],
    //    "status" : "OK"
    //}

    
    if (jsonData) {
        
        NSError* jsonParsingError = nil;
        //JSON에서 NSDictionary 또는 NSArray로 변환
        //JSON에 따라서 배열이라면 NSArray가 되고, 그렇지 않으면 NSDictionary가 된다.
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonParsingError];
        
        //NSDictionary을 이용하여 필요한 데이터를 구한다.
        NSString* status = [dic objectForKey:@"status"];
        NSLog(@"status: %@",status);
        
        NSArray* arrayResult =[dic objectForKey:@"results"];
        NSDictionary* resultDic = [arrayResult objectAtIndex:0];
        NSDictionary* geometryDic = [resultDic objectForKey:@"geometry"];
        NSLog(@"geometryDic: %@",geometryDic);
        
        NSDictionary* locationDic = [geometryDic objectForKey:@"location"];
        NSNumber* lat = [locationDic objectForKey:@"lat"];
        NSNumber* lng = [locationDic objectForKey:@"lng"];
        NSLog(@"location lat = %@, lng = %@",lat,lng);
        
    } else {
        
        NSLog(@"the connection could not be created or if the download fails.");

    }
    
}
@end
