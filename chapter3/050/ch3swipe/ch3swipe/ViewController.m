//
//  ViewController.m
//  ch3swipe
//
//  Created by katsuya on 2013/11/23.
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
    
    // UISwipeGestureRecognizer의 인스턴스를 생성한다
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleRightSwipeGesture:)];
    
    // 오른쪽 방향 스와이프를 검출하기 위해 설정한다
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    // 스와이프를 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];

    
    // UISwipeGestureRecognizer의 인스턴스를 생성한다
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                             initWithTarget:self
                                                             action:@selector(handleLeftSwipeGesture:)];
    
    // 왼쪽 방향 스와이프를 검출하기 위해 설정한다
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // 스와이프를 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];

    
    // UISwipeGestureRecognizer의 인스턴스를 생성한다
    UISwipeGestureRecognizer *upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                             initWithTarget:self
                                                             action:@selector(handleUpSwipeGesture:)];
    
    // 위 방향 스와이프를 검출하기 위해 설정한다
    upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    // 스와이프를 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:upSwipeGestureRecognizer];
    
    
    // UISwipeGestureRecognizer의 인스턴스를 생성한다
    UISwipeGestureRecognizer *downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handleDownSwipeGesture:)];
    
    // 아래 방향 스와이프를 검출하기 위해 설정한다
    downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    
    // 스와이프를 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:downSwipeGestureRecognizer];
    
    // UISwipeGestureRecognizer의 인스턴스를 생성한다
    UISwipeGestureRecognizer *twoFingerSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handleTwoFingerSwipeGesture:)];
    
    // 오른쪽 방향 스와이프를 검출하기 위해 설정한다
    twoFingerSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    // 검출할 손가락 수를 2로 설정한다(초기값은 1)
    twoFingerSwipeGestureRecognizer.numberOfTouchesRequired = 2;
    
    // 스와이프를 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:twoFingerSwipeGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleRightSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"오른쪽 방향으로 스와이프 했습니다";
}

- (void)handleLeftSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"왼쪽 방향으로 스와이프 했습니다";
}

- (void)handleUpSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"위 방향으로 스와이프 했습니다";
}

- (void)handleDownSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"아래 방향으로 스와이프 했습니다";
}

- (void)handleTwoFingerSwipeGesture:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"2 개의 손가락으로 스와이프 했습니다";
}

@end
