//
//  ViewController.m
//  ch10FaceDetector
//
//  Created by shoeisha on 2013/12/07.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UIImageView* imageView;
    
    UIImage* imagePortrait;
    UIImage* imageLandscape;
}
@end

@implementation ViewController

- (NSArray*)detectFaces
{
    // 얼굴 검출 오브젝트
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil
                                              options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];

    // 이미지
    CIImage* targetImage = [[CIImage alloc] initWithCGImage:imageView.image.CGImage];
    
    // 검출
    NSArray* results = [detector featuresInImage:targetImage
                                         options:@{
                                                   CIDetectorSmile    : [NSNumber numberWithBool:YES],
                                                   CIDetectorEyeBlink : [NSNumber numberWithBool:YES],
                                                   }];

    // CoreImage는 왼쪽 아래 원점이므로, UIKit와 같은 왼쪽 위 원점으로 변환
    CGAffineTransform transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(1, -1), 0, -imageView.bounds.size.height);

    // 마커 리스트
    NSMutableArray* list = [[NSMutableArray alloc] initWithCapacity:results.count];

    for (CIFaceFeature* result in results) {
#if 1
        // 검출 위치를 좌표 변환
        CGRect rect = CGRectApplyAffineTransform(result.bounds, transform);
        
        // 리스트 등록
        UIView* view = [[UIView alloc] initWithFrame:rect];
        view.layer.borderWidth = 2;
        if (result.hasSmile) {
            view.layer.borderColor = [[UIColor yellowColor] CGColor];       // 웃는 얼굴이라면 노란색 테두리
        } else {
            if (result.leftEyeClosed) {
                view.layer.borderColor = [[UIColor blueColor] CGColor];     // 왼쪽 눈을 감고 있으면 파란색 테두리
            } else if (result.rightEyeClosed) {
                view.layer.borderColor = [[UIColor redColor] CGColor];      // 오른쪽 눈을 감고 있으면 빨간색 테두리
            } else {
                view.layer.borderColor = [[UIColor greenColor] CGColor];    // 양쪽 눈을 뜨고 있으면 녹색 테두리
            }
        }
#else
        // 마스크 작성
        CGFloat height = result.bounds.size.height / 8;
        CGRect mask = CGRectMake(result.bounds.origin.x,
                                 (result.leftEyePosition.y + result.rightEyePosition.y - height) / 2,
                                 result.bounds.size.width, height);
        
        // 검출 위치를 좌표 변환
        CGRect rect = CGRectApplyAffineTransform(mask, transform);
        
        // 리스트 등록
        UIView* view = [[UIView alloc] initWithFrame:rect];
        view.layer.backgroundColor = [[UIColor blackColor] CGColor];
#endif
        [list addObject:view];
    }
    
    return list;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 이미지 읽어 들이기
    imagePortrait  = [UIImage imageNamed:@"MonaLisa.jpg"];
    imageLandscape = [UIImage imageNamed:@"AnatomyLesson.jpg"];
    
    // ImageView로 이미지 할당
    imageView.image = imagePortrait;

    // 얼굴 검출 마커 표시
    for (UIView* view in [self detectFaces]) [imageView addSubview:view];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

// 오리엔테이션 타입
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

// 초기 오리엔테이션
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

// 가로/세로 전환
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // 얼굴 검출 마커 삭제
    for (UIView* view in imageView.subviews) [view removeFromSuperview];
}

// 가로/세로 전환 종료
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIInterfaceOrientation orientation = self.interfaceOrientation;
    
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        // 세로 화면
        imageView.image  = imagePortrait;
        imageView.frame  = CGRectMake(-32, 20, imagePortrait.size.width, imagePortrait.size.height);
    } else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        // 가로 화면
        imageView.image  = imageLandscape;
        imageView.frame  = CGRectMake(0, 20, imageLandscape.size.width, imageLandscape.size.height);
    }

    // 얼굴 검출 마커 표시
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 얼굴 검출 백그라운드 처리
        NSArray* views = [self detectFaces];
        
        // 백그라운드 처리 종료 후 표시
        dispatch_async(dispatch_get_main_queue(), ^{
            // 검출 마커 삭제
            for (UIView* view in imageView.subviews) [view removeFromSuperview];

            // 얼굴 검출 마커 등록
            for (UIView* view in views) {
                [imageView addSubview:view];
            }
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
