//
//  ViewController.m
//  ch5trim
//
//  Created by SHOEISHA on 2013/10/14.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

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

// Load Image 버튼이 눌렸을 때 처리
- (IBAction)loadImageButtonDidPush:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

// 이미지 피커에 이미지를 선택함
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 선택된 이미지의 중앙 부분을 잘라서 표시
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    
    // 위치정보를 읽어 정보를 표시
    [self showLocationFromURL:info[UIImagePickerControllerReferenceURL] animated:YES];
    
    // 이미지 피커를 닫음
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

// AssetsLibrary를 이용해 지도 표시
- (void)showLocationFromURL:(NSURL *)url animated:(BOOL)animated
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary assetForURL:url
                  resultBlock:^(ALAsset *asset)
     {
         // Assets을 사용할 수 있는 경우
         ALAssetRepresentation *assetRepresentation = asset.defaultRepresentation;
         NSDictionary *metadata = assetRepresentation.metadata;
         // 위치 정보 구하기
         NSDictionary *gpsDic = metadata[(NSString *)kCGImagePropertyGPSDictionary];
         if (gpsDic) {
             NSNumber *longitude = gpsDic[(NSString *)kCGImagePropertyGPSLongitude];
             NSString *longitudeRef = gpsDic[(NSString *)kCGImagePropertyGPSLongitudeRef];
             NSNumber *latitude = gpsDic[(NSString *)kCGImagePropertyGPSLatitude];
             NSString *latitudeRef = gpsDic[(NSString *)kCGImagePropertyGPSLatitudeRef];
             if (longitude && longitudeRef && latitude && latitudeRef) {
                 self.locationLabel.text = [NSString stringWithFormat:@"%@%@,%@%@",longitudeRef, longitude, latitudeRef, latitude];
                 CLLocationCoordinate2D location = CLLocationCoordinate2DMake(([latitudeRef isEqualToString:@"N"] ? 1 : -1) * [latitude doubleValue], ([longitudeRef isEqualToString:@"E"] ? 1 : -1) * [longitude doubleValue]);
                 [self.mapView setCenterCoordinate:location animated:animated];
             }
         } else {
             self.locationLabel.text = @"이 이미지에는 위치 정보가 없습니다.";
         }
     }
                 failureBlock:^(NSError *error)
    {
            self.locationLabel.text = @"AssetsLibrary 사용을 실패했습니다.";
    }];
}

@end
