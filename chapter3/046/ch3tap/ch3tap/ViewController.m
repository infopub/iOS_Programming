//
//  ViewController.m
//  ch3tap
//
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UITapGestureRecognizer의 인스턴스를 생성한다
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(handleSingleTapGesture:)];
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleDoubleTapGesture:)];
    UITapGestureRecognizer *twoFingersTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                              initWithTarget:self
                                                              action:@selector(handleTwoFingersTapGesture:)];

    // 싱글 탭을 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:singleTapGestureRecognizer];

    // 검출할 탭 수를 2로 설정한다(초기값은 1)
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;

    // 더블 탭을 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];

    // 검출할 손가락 수(동시에 터치되는 수)를 2로 설정한다(초기값은 1)
    twoFingersTapGestureRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:twoFingersTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleSingleTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"싱글탭 입니다";
}

- (void)handleDoubleTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"더블탭 입니다";
}

- (void)handleTwoFingersTapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"2 개의 손가락으로 탭을 했습니다";
}

@end
