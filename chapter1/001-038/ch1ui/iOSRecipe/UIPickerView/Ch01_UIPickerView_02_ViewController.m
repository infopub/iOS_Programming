//
//  Ch01_UIPickerView_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPickerView_02_ViewController.h"
#import "PickerView2Controller.h"
#import "Ch01_AppDelegate.h"

@interface Ch01_UIPickerView_02_ViewController ()
{
    PickerView2Controller *piclerView2Controller;
}

@end

@implementation Ch01_UIPickerView_02_ViewController

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
    piclerView2Controller = [[PickerView2Controller alloc] init];
    
    piclerView2Controller.delegate = self;
    
    // PickerView를 서브뷰로써 표시한다
    UIView *pickerView = piclerView2Controller.view;
    CGPoint middleCenter = pickerView.center;
    
    // 애니메이션 시작 시의 PickerView위 위치를 계산
    UIWindow* mainWindow = (((Ch01_AppDelegate*) [UIApplication sharedApplication].delegate).window);
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    CGPoint offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height*1.5);
    pickerView.center = offScreenCenter;
    
    [mainWindow addSubview:pickerView];
    
    // 애니메이션을 사용해 PickerView를 표시한다
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    pickerView.center = middleCenter;
    [UIView commitAnimations];
}


-(void)closePickerView:(id)sender{
    // PickerView를 애니메이션을 사용해 천천히 사라지게 한다
    UIView *pickerView = ((UIViewController *)sender).view;
    
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

// PickerView를 닫고 애니메이션이 완료했을 때 호출되는 메소드
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    // PickerView를 슈퍼뷰로부터 삭제
    UIView *pickerView = (__bridge UIView *)context;
    [pickerView removeFromSuperview];
}


@end
