//
//  ViewController.m
//  ch10Gyroscope
//
//  Created by shoeisha on 2013/11/04.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "ViewController.h"

@interface ViewController ()
{
    IBOutlet UILabel* x;
    IBOutlet UILabel* y;
    IBOutlet UILabel* z;
    
    IBOutlet UILabel* yaw;
    IBOutlet UILabel* pitch;
    IBOutlet UILabel* roll;
    
    CMMotionManager* manager;
}
@end

@implementation ViewController

- (IBAction)stop:(UIButton*)sender
{
    if (manager.deviceMotionActive) {
        [manager stopDeviceMotionUpdates];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // MotionManager를 생성
    manager = [[CMMotionManager alloc] init];

    // 취득 간격을 지정(상한은 하드웨어 의존 < 100Hz)
    manager.deviceMotionUpdateInterval = 0.1; // 10Hz

    // 센서 취득의 여부를 확인
    if (manager.deviceMotionAvailable) {
#if 0
        // PULL형 : 이후、각 파라미터가 자동 갱신된다
        [manager startDeviceMotionUpdates];
#else
        // PUSH형 : 이후、지정한 사용자 처리가 주기적으로 실행된다
        [manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(CMDeviceMotion* motion, NSError* error) {
                                         // 자이로스코프 데이터 구하기[rad/s : πrad = 180°]
                                         CMRotationRate rot = motion.rotationRate;
                                         x.text = [NSString stringWithFormat:@"%.2f", rot.x];
                                         y.text = [NSString stringWithFormat:@"%.2f", rot.y];
                                         z.text = [NSString stringWithFormat:@"%.2f", rot.z];
                                         
                                         // 방향 (yaw / pitch / roll)[rad]
                                         CMAttitude* att = motion.attitude;
                                         yaw.text   = [NSString stringWithFormat:@"%.2f", att.yaw];
                                         pitch.text = [NSString stringWithFormat:@"%.2f", att.pitch];
                                         roll.text  = [NSString stringWithFormat:@"%.2f", att.roll];
                                     }];
#endif
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self stop:nil];
}

@end
