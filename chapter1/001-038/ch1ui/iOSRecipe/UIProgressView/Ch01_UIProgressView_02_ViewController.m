//
//  Ch01_005_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2013/10/25.
//  Copyright (c) 2013年 shaoeisya. All rights reserved.
//

#import "Ch01_UIProgressView_02_ViewController.h"

@interface Ch01_UIProgressView_02_ViewController ()

@end

@implementation Ch01_UIProgressView_02_ViewController

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
    
    // 스타일을 Default로 설정
    self.progressview1.progressViewStyle = UIProgressViewStyleDefault;
    // 왼쪽 색을 빨강으로 설정
    self.progressview1.progressTintColor = [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    // 오른쪽 색을 초록으로 설정
    self.progressview1.trackTintColor = [UIColor colorWithRed:0.0f/255.0f green:255.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
}

-(void)viewDidAppear:(BOOL)bl{
    [super viewDidAppear:bl];
    // 가로 방향으로 1배, 세로 방향을 12.0f로 변경할 때의 배율은 자동 계산(iOS7에서 height=2이기 때문에 배율은 6으로 된다）
    self.progressview2.transform = CGAffineTransformMakeScale(1.0f, 12.0f/ self.progressview1.bounds.size.height);
    
    // 시계 방향으로 90도 회전해서 표시
    self.progressview3.transform = CGAffineTransformMakeRotation(90.0f * M_PI/180.f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
