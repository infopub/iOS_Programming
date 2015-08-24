//
//  Ch01_UIPopoverController_02_ViewController.m
//  iOSRecipe
//
//  Created by adminfeng on 2014/01/13.
//  Copyright (c) 2014年 shaoeisya. All rights reserved.
//

#import "Ch01_UIPopoverController_02_ViewController.h"

@interface Ch01_UIPopoverController_02_ViewController ()
{
    UIPopoverController * popover;
}
@end

@implementation Ch01_UIPopoverController_02_ViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPopover:(id)sender {
    // 팝 오버 내에 표시하는 화면을 초기화
    // 이 화면은 ViewController를 상속
    Content2ViewController *contentViewController = [[Content2ViewController alloc] init];
    
    popover.delegate = self;
    
    // 팝 오버 내에 표시하는 화면을 초기화
    // 다음에 메소드 「setContentViewController:animated:」에서 변경할 수 있다.
    popover = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    
    // 팝 오버의 크기를 지정
    popover.popoverContentSize = CGSizeMake(320., 320.);
    
    contentViewController.delegate = self;
    
    UIButton *tappedButton = (UIButton *)sender;
    // 팝 오버 앵커 표시 방향을 지정해서 표시
    [popover presentPopoverFromRect:tappedButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    popover = nil;
}

-(void)closePopover:(Content2ViewController *)sender{
    if (popover) {
        [popover dismissPopoverAnimated:YES];
        popover = nil;
    }
}

@end
