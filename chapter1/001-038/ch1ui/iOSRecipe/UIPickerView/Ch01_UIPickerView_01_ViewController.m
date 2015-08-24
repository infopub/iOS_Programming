//
//  Ch01_UIPickerView_01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPickerView_01_ViewController.h"
#import "PickerViewController.h"
#import "Ch01_AppDelegate.h"

@interface Ch01_UIPickerView_01_ViewController ()
{
    PickerViewController *piclerViewController;
}
@end

@implementation Ch01_UIPickerView_01_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPickerView:(id)sender {
    piclerViewController = [[PickerViewController alloc] init];
    
    piclerViewController.delegate = self;
    
    // PickerView를 서브뷰로 표시
    UIView *pickerView = piclerViewController.view;
    CGPoint middleCenter = pickerView.center;
    
    // 애니메이션 시직 시의 PickerView의 위치를 계산
    UIWindow* mainWindow = (((Ch01_AppDelegate*) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height*1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // 애니메이션을 사용해서 PickerView를 표시
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    pickerView.center = middleCenter;
    [UIView commitAnimations];
}

-(void)closePickerView:(PickerViewController *)sender{
    // PickerView를 애니메이션을 사용해 천천히 사라지게 함
    UIView *pickerView = sender.view;
    
    // 애니메이션 완료 시의 PickerView의 위치를 계산
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(void *)pickerView];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    // 애니메이션 종료 시에 호출할 처리를 설정
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    pickerView.center = offScreenCenter;
    [UIView commitAnimations];
}

// 단위 PickerView를 닫고 애니메이션이 종료될 때 호출되는 메소드
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerView를 슈퍼뷰로부터 삭제
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}

@end
