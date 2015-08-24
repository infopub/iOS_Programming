//
//  ViewController.m
//  ch5trim
//
//  Created by SHOEISHA on 2013/10/14.
//  Copyright (c) 2013年 SHOEISHA. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSURL *imageURL;
}

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

// Load Image 버튼을 눌렀을 때의 처리
- (IBAction)loadImageButtonDidPush:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

// 이미지 피커에 이미지가 선택됨
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 선택된 이미지의 중앙 부분을 잘라서 표시
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    CGImageRef imageRef = [image CGImage];

    int trimX = image.size.width / 2 - 80;
    if (trimX < 0) {
        trimX = 0;
    }
    int trimY = image.size.height / 2 - 80;
    if (trimY < 0) {
        trimY = 0;
    }
    CGRect trimRect = CGRectMake(trimX, trimY, 320, 320);

    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, trimRect);
//    self.imageView.image = [UIImage imageWithCGImage:newImageRef];
    self.leftImageView.image = [UIImage imageWithCGImage:newImageRef scale:2.0 orientation:UIImageOrientationUp];
    self.rightImageView.image = self.leftImageView.image;
    // createCGImage에서 작성한 CGImage 해제
    CGImageRelease(newImageRef);
    
    // 원본 파일의 URL을 저장
    imageURL = info[UIImagePickerControllerReferenceURL];
    
    // 이미지 피커를 닫는다
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 이미지 잘라내기
- (IBAction)cropButtonDidPush:(id)sender
{
    UIImage *image = self.leftImageView.image;
    if (image) {
        CGFloat scale = image.scale;
        UIImageOrientation orientation = image.imageOrientation;
            
        CGImageRef imageRef = [image CGImage];
        // 이미지 주위의 10픽셀을 잘라내기
        int trimX, trimY;
        int trimWidth = (image.size.width - 20) * scale;
        int trimHeight = (image.size.height - 20) * scale;

        if (trimWidth > 0) {
            trimX = 10 * scale;
        } else {
            trimX = 0;
            trimWidth = image.size.width;
        }
        if (trimHeight > 0) {
            trimY = 10 * scale;
        } else {
            trimY = 0;
            trimHeight = image.size.height;
        }

        CGRect trimRect = CGRectMake(trimX, trimY, trimWidth, trimHeight);
        
        CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, trimRect);
        self.rightImageView.image = [UIImage imageWithCGImage:newImageRef scale:scale orientation:orientation];
        // CGImageCreateWithImageInRect에 작성한 CGImage의 해제
        CGImageRelease(newImageRef);
    }
}

@end
