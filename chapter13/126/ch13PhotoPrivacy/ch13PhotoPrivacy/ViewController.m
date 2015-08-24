//
//  ViewController.m
//  ch13PhotoPrivacy
//
//  Created by HU QIAO on 2013/11/26.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIImagePickerController *imagePickerController;

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

- (IBAction)checkPhotosAuthorizationStatus:(id)sender {
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    // 사용자에게 아직 접근 허가를 요구하지 않은 경우
    if(status == ALAuthorizationStatusNotDetermined) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"사용자에게 아직 접근을 허가하지 않는다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // iPhone 설정의 「차단」에서 사진으로의 접근을 제한하는 경우
    else if(status == ALAuthorizationStatusRestricted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"iPhone 설정의 「차단」에서 사진으로의 접근을 제어한다 "
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 사진으로의 접근을 사용자가 거부한 경우
    else if(status == ALAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"사진으로의 접근을 사용자가 거부한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    // 사진으로의 접근을 사용자가 허가한 경우
    else if(status == ALAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                        message:@"사진으로의 접근을 사용자가 허가한다"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)showAlbum:(id)sender {
    
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
            // iPhone 설정의 「차단」에서 사진으로의 접근을 제어하는 경우
        case ALAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"iPhone의 설정 「차단」에서 사진으로의 접근을 제어한다"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
            
            // 사진으로의 접근을 사용자가 거부한 경우
        case ALAuthorizationStatusDenied:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"사진으로의 접근을 사용자가 거부한다"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
            // 사용자에게 아직 접근 허가를 요구하지 않은 경우
        case ALAuthorizationStatusNotDetermined:
            // 사진으로의 접근을 사용자가 허가한 경우
        case ALAuthorizationStatusAuthorized:
        {
            [self showImagePickerController];
        }
            break;
        default:
            break;
    }
    
}


// 앨범을 표시
-(void)showImagePickerController
{
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
    
	// 사용자에게 아직 접근 허가를 요구하지 않은 경우
    if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusNotDetermined) {
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (*stop) {
                // 사용자가 접근을 하가한 경우
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                                message:@"사진으로의 접근을 사용자가 허가하였다"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
                return;
            }
            *stop = TRUE;
        } failureBlock:^(NSError *error) {
            // 사진으로의 접근을 사용자가 거부한 경우
            [self dismissViewControllerAnimated:YES completion:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"개인 정보 보호 상태"
                                                            message:@"사진으로의 접근을 사용자로부터 거부한다"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
        }];
    }
}


#pragma mark - UIImagePicker delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissPicker:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissPicker:picker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    [self dismissPicker:picker];
}

- (void)dismissPicker:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
