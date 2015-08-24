//
//  ViewController.m
//  ch3pan
//
//  Created by katsuya on 2013/11/21.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lacationLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIPanGestureRecognizer의 인스턴스를 생성한다
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handlePanGesture:)];
    
    // 팬을 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    // UIPanGestureRecognizer의 인스턴스를 생성한다
    UIPanGestureRecognizer *twoFingerPanGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleTwoFingerPanGesture:)];
    
    // 검출할 최대 손가락 수를 설정한다(초기값은 1)
    twoFingerPanGestureRecognizer.maximumNumberOfTouches = 2;
    // 검출할 최소 손가락 수를 설정한다(초기값은 1)
    twoFingerPanGestureRecognizer.minimumNumberOfTouches = 2;
    
    // 팬을 검출하기 위해 GestureRecognizer를 View에 설정한다
    [self.view addGestureRecognizer:twoFingerPanGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGPoint location = [gestureRecognizer translationInView:self.view];
    self.label.text = @"1 개의 손가락으로 팬 제스쳐를 했습니다";
    self.lacationLabel.text = [NSString stringWithFormat:@"x:%f  y:%f", location.x, location.y];
}

- (void)handleTwoFingerPanGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    CGPoint location = [gestureRecognizer translationInView:self.view];
    self.label.text = @"2 개의 손가락으로 팬 제스쳐를 했습니다";
    self.lacationLabel.text = [NSString stringWithFormat:@"x:%f  y:%f", location.x, location.y];
}


@end
