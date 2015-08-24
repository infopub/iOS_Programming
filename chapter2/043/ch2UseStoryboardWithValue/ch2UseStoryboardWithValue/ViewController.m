//
//  ViewController.m
//  ch2UseStoryboardWithValue
//
//  Created by shoeisha on 2013/12/01.
//  Copyright (c) 2013年 shoeisha. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 세그웨이로부터 전환처 화면의 ViewContoller를 취득
    SubViewController *subViewController = [segue destinationViewController];

    // 데이터 수신용 프로퍼티에 데이터를 설정
    if ( [[segue identifier] isEqualToString:@"segue1"] ) {
        subViewController.receiveString = @"from button 1";
    } else {
        subViewController.receiveString = @"from button 2";
    }
}

@end
