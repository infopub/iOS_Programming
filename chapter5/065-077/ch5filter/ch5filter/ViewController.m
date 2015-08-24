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
    CGImageRef originalImageRef;
    NSArray *filterNames;
    NSArray *filterArray;
    NSString *nameKey;
    NSString *filterNameKey;
    NSString *parametersKey;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSNull *null = [NSNull null];
    NSArray *empty = @[];

    nameKey = @"Name";
    filterNameKey = @"FilterName";
    parametersKey = @"Parameters";
    
    /*
     연관 배열에 필터의 이름, 설정 정보를 설정
     */
    filterArray = @[
                    @{
                        nameKey: @"필터 없음",
                        filterNameKey: null,
                        parametersKey: empty,
                    },
                    // 색조를 설정
                    @{
                        nameKey: @"이미지 반전",
                        filterNameKey: @"CIColorInvert",
                        parametersKey: empty,
                    },
                    @{
                        nameKey: @"모노크롬",
                        filterNameKey: @"CIColorMonochrome",
                        parametersKey: @{
                                kCIInputColorKey: [CIColor colorWithRed:0.5 green:0.5 blue:0.5],
                                kCIInputIntensityKey: @1.0,
                        },
                    },
                    @{
                        nameKey: @"세피아톤",
                        filterNameKey: @"CISepiaTone",
                        parametersKey: @{
                                kCIInputIntensityKey: @1.0,
                        },
                    },
                    @{
                        nameKey: @"포스터화",
                        filterNameKey: @"CIColorPosterize",
                        parametersKey: @{@"inputLevels": @2.0},
                        },
                    @{
                        nameKey: @"감마비",
                        filterNameKey: @"CIGammaAdjust",
                        parametersKey: @{
                                @"inputPower": @1.2,
                                },
                        },
                    @{
                        nameKey: @"명도・대비",
                        filterNameKey: @"CIColorControls",
                        parametersKey: @{
                                kCIInputBrightnessKey: @0.5,
                                kCIInputContrastKey: @2.0,
                                },
                        },
                    @{
                        nameKey: @"채도",
                        filterNameKey: @"CIColorControls",
                        parametersKey: @{
                                kCIInputSaturationKey: @2.0,
                        },
                    },
                    @{
                        nameKey: @"활기(Vibrance)",
                        filterNameKey: @"CIVibrance",
                        parametersKey: @{
                                @"inputAmount": @1.0,
                                },
                        },
                    @{
                        nameKey: @"색상",
                        filterNameKey: @"CIHueAdjust",
                        parametersKey: @{
                                kCIInputAngleKey: @M_PI_2,
                        },
                    },
                    @{
                        nameKey: @"가우시안 효과",
                        filterNameKey: @"CIGaussianBlur",
                        parametersKey: @{
                                kCIInputRadiusKey: @3.0,
                        },
                    },
                    @{
                        nameKey: @"선명도",
                        filterNameKey: @"CIUnsharpMask",
                        parametersKey: @{
                                kCIInputRadiusKey: @3.0,
                        },
                    },
                    @{
                        nameKey: @"물방울 스크린",
                        filterNameKey: @"CIDotScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputAngleKey: @M_PI_4,
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                        },
                    },
                    @{
                        nameKey: @"회오리 스크린",
                        filterNameKey: @"CICircularScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                                },
                        },
                    @{
                        nameKey: @"격자무늬 스크린",
                        filterNameKey: @"CIHatchedScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputAngleKey: @M_PI_4,
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                        },
                    },
                    @{
                        nameKey: @"직선 스크린",
                        filterNameKey: @"CILineScreen",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputAngleKey: @M_PI_4,
                                kCIInputWidthKey: @6.0,
                                @"inputSharpness": @0.5,
                                },
                        },
                    @{
                        nameKey: @"픽셀레이트",
                        filterNameKey: @"CIPixellate",
                        parametersKey: @{
                                kCIInputCenterKey: [CIVector vectorWithX:160.0 Y:160.0],
                                kCIInputScaleKey: @10.0,
                        },
                    },
    ];
    originalImageRef = CGImageRetain([self.rightImageView.image CGImage]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Load Image 버튼이 눌렸을 때의 처리
- (IBAction)loadImageButtonDidPush:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (UIImage *)execImageWithCGImage:(CGImageRef)imageRef
{
    return [UIImage imageWithCGImage:imageRef scale:2.0 orientation:UIImageOrientationUp];
}

// 이미지 피커에 이미지가 선택되었음
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 선택된 이미지의 중앙 부분을 잘라내서 표시
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

    // 편집 후의 CGImageRef가 남아 있으면 해제
    if (originalImageRef) {
        CGImageRelease(originalImageRef);
    }
    
    originalImageRef = CGImageCreateWithImageInRect(imageRef, trimRect);
    // 왼쪽(원본) 이미지를 바꿈
    UIImage *thumbImage = [self execImageWithCGImage:originalImageRef];
    self.leftImageView.image = thumbImage;
    self.rightImageView.image = thumbImage;
    
    // 이미지 피커를 닫는다
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 피커뷰를 초기 상태로 되돌린다
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
}

// UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return filterArray.count;
}

// UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return filterArray[row][nameKey];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 피커 뷰의 선택 상황에 따라서 필터를 적용
    if (row > 0) {
        // UIImage로부터 CIImage를 생성
        CIImage *image = [CIImage imageWithCGImage:originalImageRef];
        CIFilter *filter;
        
        // 필터를 설정
        NSDictionary *filterDic = filterArray[row];
        filter = [CIFilter filterWithName:filterDic[filterNameKey]];
        NSDictionary *paramDic = filterDic[parametersKey];

        // 연관 배열을 이용하여 필터 매개변수를 설정
        [filter setValuesForKeysWithDictionary:paramDic];

        // 기본 이미지를 지정
        [filter setValue:image forKey:kCIInputImageKey];

        // 필터 적용 후의 이미지를 구함
        CIImage *newImage = filter.outputImage;
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef newImageRef = [context createCGImage:newImage fromRect:newImage.extent];
        
        // 이미지를 오른쪽 이미지 뷰에 설정
        self.rightImageView.image = [self execImageWithCGImage:newImageRef];
        
        // createCGImage에서 생성한 CGImage 해제
        CGImageRelease(newImageRef);
    } else {
        // 원본 이미지를 표시
        self.rightImageView.image = self.leftImageView.image;
    }
}

@end
