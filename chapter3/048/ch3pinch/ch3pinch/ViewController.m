//
//  ViewController.m
//  ch3pinch
//
//  Created by katsuya on 2013/11/23.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // UIPinchGestureRecognizer의 인스턴스를 생성한다
  UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(handlePinchGesture:)];
  
  // 핀치를 검출하기 위해 GestureRecognizer를 View에 설정한다
  [self.view addGestureRecognizer:pinchGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  CGFloat scale = gestureRecognizer.scale;
  CGFloat velocity= gestureRecognizer.velocity;
  
  if (velocity > 0) {
    self.label.text = @"핀치아웃을 했습니다";
  } else {
    self.label.text = @"핀치인을 했습니다";
  }
  
  self.valueLabel.text = [NSString stringWithFormat:@"Scale:%f  Velocity:%f", scale, velocity];
}

@end
