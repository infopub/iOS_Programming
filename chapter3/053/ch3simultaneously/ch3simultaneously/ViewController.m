//
//  ViewController.m
//  ch3simultaneously
//
//  Created by katsuya on 2013/11/26.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rotationLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinchLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIPinchGestureRecognizer의 인스턴스를 생성한다
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinchGesture:)];
    
    // delegate를 설정한다
    pinchGestureRecognizer.delegate = self;
    
    // 핀치를 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:pinchGestureRecognizer];

    // UIRotationGestureRecognizer의 인스턴스를 생성한다
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]
                                                              initWithTarget:self
                                                              action:@selector(handleRotationGesture:)];

    // delegate를 설정한다
    rotationGestureRecognizer.delegate = self;

    // 회전을 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:rotationGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.pinchLabel.text = @"핀치를 했습니다";
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);

    self.rotationLabel.text = @"회전을 했습니다";
}

@end
