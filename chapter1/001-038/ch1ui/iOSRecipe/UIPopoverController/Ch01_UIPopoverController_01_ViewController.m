//
//  Ch01_ UIPopoverController _01_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/12.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPopoverController_01_ViewController.h"
#include "ContentViewController.h"

@interface Ch01_UIPopoverController_01_ViewController ()
{
    UIPopoverController *popover;
}
@end

@implementation Ch01_UIPopoverController_01_ViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)showPopOver:(id)sender {
    
    // 팝 오버 내에 표시하는 화면을 초기화
    // 이 화면은 ViewController를 상속
    ContentViewController *contentViewController = [[ContentViewController alloc] init];
    
    // 팝 오버 내에 표시하는 화면을 초기화
    // 다음에 메소드 「setContentViewController:animated:」에서 변경할 수 있다.
    popover = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    
    // 팝 오버의 크기를 지정
    popover.popoverContentSize = CGSizeMake(320., 320.);
    
    // 팝 오버의 배경색을 지정
    popover.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:255.0/255.0 alpha:0.5];
    
    // 팝 오버를 종료하지 않는 외부 뷰를 지정
    popover.passthroughViews = @[self.textField];
    
    UIButton *tappedButton = (UIButton *)sender;
    // 팝 오버의 앵커 표시 방향을 지정해서 표시
    [popover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
