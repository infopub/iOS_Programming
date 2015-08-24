//
//  ViewController.m
//  Rate
//
//  Created by katsuya on 2014/01/21.
//  Copyright (c) 2014年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "iRate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // id를 임의의 앱 ID로 바꿔놓는다
    [iRate sharedInstance].appStoreID = 443904275;
    
    // 앱의 사용 횟수
    [iRate sharedInstance].usesCount = 10;
    
    // 특정 「이벤트」를 통과한 횟수. 특정 이벤트를 실행하면 logEvent메소드가 호출되도록 구현한다
    [iRate sharedInstance].eventsUntilPrompt = 10;
    
    // 앱의 사용 일수
    [iRate sharedInstance].daysUntilPrompt = 10;
    
    // 앱의 매주 사용 횟수
    [iRate sharedInstance].usesPerWeekForPrompt = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
