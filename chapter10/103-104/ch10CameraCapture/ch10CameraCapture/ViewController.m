//
//  ViewController.m
//  ch10CameraCapture
//
//  Created by shoeisha on 2013/12/08.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView* imageView;
    IBOutlet UILabel* label;
    IBOutlet UIButton* save;
}
@end

@implementation ViewController

- (IBAction)takePicture:(id)sender
{
    // 카메라를 이용할 수 있는지 확인
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // 인스턴스 생성
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];

        // 카메라에서의 취득을 지정
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // 촬영 후의 편집 불가
        imagePickerController.allowsEditing = NO;

        // 델리게이트를 이 클래스에 지정
        imagePickerController.delegate = self;
        
        // 실행
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

// 촬영 종료 시에 호출되는 메소드
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 촬영한 이미지를 ImageView로 전달한다
    imageView.image = (UIImage*)[info objectForKey:UIImagePickerControllerOriginalImage];
   
    label.text   = [NSString stringWithFormat:@"%.f x %.f", imageView.image.size.width, imageView.image.size.height];
    save.enabled = YES;

    // 카메라를 닫는다
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 촬영 취소 시에 호출되는 메소드
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    label.text = @"Canceled";

    // 촬영이 취소된 경우도 카메라를 닫는다
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture:(id)sender
{
    // 사진을 포토앨범에 저장
    UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 저장 종료 시에 호출되는 메소드
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        // 저장 실패의 사용자 처리
        NSLog(@"%@ : %@ (%d) ", error.domain, error.localizedDescription, error.code);
    } else {
        // 저장 성공의 사용자 처리 
        save.enabled = NO;
    }
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

@end
