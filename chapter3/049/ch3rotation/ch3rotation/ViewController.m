//
//  ViewController.m
//  ch3rotation
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
  
  // UIRotationGestureRecognizer의 인스턴스를 생성한다
  UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleRotationGesture:)];
  
  // 회전을 검출하기 위해 GestureRecognizer를 View에 설정한다
  [self.view addGestureRecognizer:rotationGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)gestureRecognizer
{
  NSLog(@"%s", __PRETTY_FUNCTION__);
  CGFloat rotation = gestureRecognizer.rotation;
  CGFloat velocity= gestureRecognizer.velocity;

  if (rotation > 0) {
    self.label.text = @"오른쪽 회전을 했습니다";
  } else {
    self.label.text = @"왼쪽 회전을 했습니다";
  }

  self.valueLabel.text = [NSString stringWithFormat:@"Rotation:%f  Velocity:%f", rotation, velocity];
}

@end
