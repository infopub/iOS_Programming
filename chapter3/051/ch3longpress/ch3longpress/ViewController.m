//
//  ViewController.m
//  ch3longpress
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

    // UILongPressGestureRecognizer의 인스턴스를 생성한다
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGesture:)];
    
    // 허용할 손가락의 이동 범위를 지정한다
    longPressGestureRecognizer.allowableMovement = 20;  // 20px
    
    // 이벤트가 벌생할 때까지 길게 누르고 있을 시간을 설정한다(초기값은 0.5초)
    longPressGestureRecognizer.minimumPressDuration = 0.3f; // 0.3秒
    
    // 길게 눌림을 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:longPressGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.label.text = @"길게 눌렀습니다";
}

@end
